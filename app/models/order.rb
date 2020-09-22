class Order < ApplicationRecord

  belongs_to :user

  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders, dependent: :destroy

  monetize :amount_cents

  def total_price
   product_orders.map { |item| item.product.price_cents }.sum
  end

end

