class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show, :filter]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def home
    @products = policy_scope(Product)
    @products = Product.where.not(latitude: nil, longitude: nil)
    @markers = @products.geocoded.map do |product|
      {
        lat: product.latitude,
        lng: product.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { product: product })
      }
    end
    @featured_products = @products.all.sample(12)
  end

  def index
    if params[:query].present?
    @products = Product.search_by_product(params[:query]).page(params[:page])
    else
    @products = Product.page(params[:page])
    end
  end

  def show
    @product_orders = ProductOrder.new
    @user = current_user
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

  def save_item
    @product = Product.find(params[:id])
    current_user.favorited?(@product) ? current_user.unfavorite(@product) : current_user.favorite(@product)
  end

  def saved_items
    @favorite_products = current_user.favorited_by_type('Product')
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
      :address,
      :category,
      :colour,
      :condition,
      :size,
      :price_cents,
      :sale_type,
      # :payment_options,
      # :deliver_option,
      photos: []
    )
  end

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end
end
