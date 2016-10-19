class UpdateSearchRankService < Service
  include ApplicationHelper

  ITEMS_PER_PAGE = 10
  ALL_CATEGORY_AVAILABLE_PAGES = 5

  def initialize(search_rank_id)
    super
    # Initialize request params
    @rank = Rank.find_by_id(search_rank_id)
    raise "Rank with id=#{search_rank_id} not found." if @rank.nil?
    @term = @rank.search_term.term
    @asin = @rank.search_term.product.asin
  end

  private

  def perform_action
    items = []

    # Store information to items array
    1.upto(ALL_CATEGORY_AVAILABLE_PAGES) do |item_page|
      items.concat get_items(make_request(item_page), item_page)
    end

    save_search_rank(items)
  end

  def make_request(item_page)
    vacuum.item_search(
      query: {
        'Keywords' => @term,
        'SearchIndex' => 'All',
        'ItemPage' => item_page
      }
    )
  rescue => details
    raise details, "Error: couldn't do item search. Check your Amazon credentials. #{details}"
  end

  # ASIN: items[i][:data]['ASIN']
  # Title: items[i][:data]['ItemAttributes']['Title']
  # Position: items[i][:position]
  # Price: not provided
  def get_items(response, item_page)
    items = []
    response = response.to_h
    if response.key?('ItemSearchResponse') &&
       response['ItemSearchResponse'].key?('Items') &&
       response['ItemSearchResponse']['Items'].key?('Item')
      response['ItemSearchResponse']['Items']['Item'].each_with_index do |item, pos|
        items << { position: (item_page - 1) * ITEMS_PER_PAGE + pos + 1, data: item }
      end
    end
    items
  end

  def save_search_rank(items)
    bsr = items.detect { |item| item[:data]['ASIN'] == @asin }[:position]
    # if ASIN not found don't add any information
    if bsr.nil?
      raise "ASIN #{bsr} not found."
    else
      @rank.data << { time: Time.now, bsr: bsr }
      @rank.save
    end
  end
end
