class ProductInformationLoader < Service
  include ApplicationHelper

  attr_reader :asin, :data

  def initialize(asin)
    super
    @asin = asin
    @data = {}
  end

  private

  def perform_action
    perform_request!
    if response_success?
      succeed!
      build_information_hash
    else
      set_errors!
      fail!
    end
  end

  def build_information_hash
    @data = {}.tap do |h|
      h[:title] = @response.css('ItemAttributes Title').text
      h[:manufacturer] = @response.css('ItemAttributes Manufacturer').text
    end
  end

  def set_errors!
    @errors = [@response.css('Errors Message').text]
  end

  def response_success?
    @response.css('Errors').empty?
  end

  def perform_request!
    @response = perform_request
  end

  def perform_request
    response = vacuum.item_lookup(query: { 'ItemId' => asin })
    Nokogiri::XML(response.body)
  end
end
