class OrdersController < ApplicationController
  skip_after_action :verify_authorized
  skip_before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = policy_scope(Order)
  end

  def my_account
    @orders = Order.where(user: current_user)
  end

  def show
    @order.user = current_user
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    authorize @order
    if @order.save
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def edit; end

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
