class OrdersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = policy_scope(Order)
  end

  def my_account
    @products = policy_scope(Product)
    @orders = Order.where(user: current_user)
    authorize @orders
  end

  def confirmation_page
    @products = policy_scope(Product)
    @orders = Order.where(user: current_user)
    authorize @orders
  end

  def show; end

  def edit; end

  def create
    product = Product.find(params[:product_id])
    order = Order.create!(
      product: product,
      product_sku: product.sku,
      amount: product.price,
      state: 'pending',
      user: current_user
    )

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: product.sku,
        images: [product.photo_url],
        amount: product.price_cents,
        currency: 'gbp',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
    authorize @order

    if @order.save
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def update
    @order.update(order_params)
    redirect_to order_path(@order)
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:state, :user, :product)
  end

  def set_order
    @order = Order.find(params[:id])
    authorize @order
  end
end
