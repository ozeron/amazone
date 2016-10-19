class CreateProductService < Service
  attr_reader :params, :user, :product
  delegate :save, to: :product, prefix: true

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
    load_and_set_metadata
    if product_save
      succeed!
    else
      set_errors!
      fail!
    end
  end

  def prepare_product
    @product = Product.new(user: user, asin: asin)
  end

  def load_and_set_metadata
    @metadata = load_metadata
    if metadata_ok?
      set_metadata
    end
  end

  def load_metadata
    operation = ProductInformationLoader.new(asin)
    operation.perform!
    if operation.failed?
      @errors << operation.errors
    end
    operation.data
  end

  def set_metadata
    @product.metadata = @metadata
  end

  def set_errors!
    @errors << @product.errors.full_messages
  end

  def metadata_ok?
    @metadata&.key?(:title) && @errors&.empty?
  end

  def asin
    product_params.fetch('asin')
  end

  def product_params
    params.require(:product).permit(:asin)
  end
end
