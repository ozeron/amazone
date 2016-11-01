class CreateSearchTermsService < Service
  attr_reader :params, :user, :product
  delegate :save, to: :search_terms, prefix: true

  def self.prepare(params, user)
    new(params, user)
  end

  def initialize(params, user)
    super
    @params = params
    @user = user
  end

  private

  def perform_action
    prepare_product
    prepare_search_terms
    if save_search_terms
      succeed!
    else
      set_errors!
      fail!
    end
  end

  def prepare_product
    @product = Product.find_by(user: user, id: product_id)
  end

  def prepare_search_terms
    new_search_terms.each do |term|
      @product.search_terms << SearchTerm.new(term: term)
    end
  end

  def new_search_terms
    terms - product.search_terms.pluck(:term)
  end

  def save_search_terms
    product.search_terms.map(&:save!)
  end

  def set_errors!
    @errors << @product.search_terms.map(&:errors).map(&:full_messages).uniq
  end

  def product_id
    product_params.fetch(:product_id)
  end

  def terms
    params.fetch(:search_terms).split(/[\r\n]/).select(&:present?)
  end

  def product_params
    params.permit(:product_id, :search_terms)
  end
end
