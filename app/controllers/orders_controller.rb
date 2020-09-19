class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = policy_scope(Order)
  end

  def my_account
    @products = policy_scope(Product)
    @orders = Order.where(user: current_user)
    @featured_products = @products.all.sample(3)
    authorize @orders
  end

  def checkout
    @order = Order.find(params[:order_id])
    authorize @order
  end

  def confirmation_page
    @order = Order.find(params[:order_id])
    authorize @order
  end

  def reviews
    @products = policy_scope(Product)
    @user = current_user
    @orders = Order.where(user: current_user)
    authorize @orders
  end

  def sale_items
    @products = policy_scope(Product)
    @user = current_user
    @orders = Order.where(user: current_user)
    authorize @orders
  end

  def show; end

  def edit
    @products = @order.products
    @users = @products.map { |product| product.user }.uniq
    @similar_products = @users.map { |user| user.products }.flatten - @products
  end

  def update
    @order.update(order_params)
    Order.create user: current_user, state: "pending"
    redirect_to order_confirmation_page_path(@order)
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:state, :user, :product, :delivery_option, :payment_option)
  end

  def set_order
    @order = Order.find(params[:id])
    authorize @order
  end
end
