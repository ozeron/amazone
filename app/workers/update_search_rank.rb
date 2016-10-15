class UpdateSearchRank
  @queue = :search_rank_queue

  ITEMS_PER_PAGE = 10
  ALL_CATEGORY_AVAILABLE_PAGES = 5

  def self.perform(search_rank_id)
    request = Vacuum.new

    request.configure(
        aws_access_key_id: Rails.configuration.amazon['aws_access_key_id'],
        aws_secret_access_key: Rails.configuration.amazon['aws_secret_access_key'],
        associate_tag: Rails.configuration.amazon['associate_tag'],
    )

    rank = Rank.find_by_id(search_rank_id)
    term = rank.search_term.term
    asin = rank.search_term.product.asin

    # ASIN: items[i][:data]['ASIN']
    # Title: items[i][:data]['ItemAttributes']['Title']
    # Position: items[i][:position]
    # Price: not provided
    items = []

    1.upto(ALL_CATEGORY_AVAILABLE_PAGES) do |item_page|
      begin
        response = request.item_search(
            query: {
                'Keywords' => term,
                'SearchIndex' => 'All',
                'ItemPage' => item_page
            }
        )
      rescue => details
        raise details, "Error: couldn't do item search. Check your Amazon credentials. #{details}"
      end

      # Store items information
      response.to_h['ItemSearchResponse']['Items']['Item'].each_with_index do |item, pos|
        items << { position: (item_page - 1) * ITEMS_PER_PAGE + pos + 1, data: item }
      end
    end

    bsr = items.detect { |item| item[:data]['ASIN'] == asin }[:position]
    # if ASIN not found don't add any information
    if bsr.nil?
      puts "ASIN #{bsr} not found."
    else
      rank.data << { time: Time.now, bsr: bsr }
      rank.save
    end
  end
end
