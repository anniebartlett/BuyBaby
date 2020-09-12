class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show, :filter]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def home
    @products = policy_scope(Product)
    @featured_products = @products.all.sample(3)

  end

  def index
    # @products = policy_scope(Product)
    # @product = Product.where.not(latitude: nil, longitude: nil)
    # @markers = @products.geocoded.map do |product|
    #   {
    #     lat: product.latitude,
    #     lng: product.longitude,
    #     infoWindow: render_to_string(partial: "info_window", locals: { product: product })
    #   }
    # end
    if params[:query].present?
      @products = Product.search_by_product(params[:query])
    else
      @products = policy_scope(Product)
    end
  end

  def show
    @product_orders = ProductOrder.new
    @order = Order.new
  end

  def new
    @product = Product.new
    authorize @product
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    authorize @product
    if @product.save!
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def update
    @product.update(product_params)
    if @product.save
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to product_path
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :location,
      :category,
      :colour,
      :condition,
      :size,
      :price_cents,
      # :payment_options,
      # :deliver_option,
      photos: [])
  end

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end
end
