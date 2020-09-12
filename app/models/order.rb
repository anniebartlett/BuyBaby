class Order < ApplicationRecord

  belongs_to :user

  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders, dependent: :destroy

  monetize :amount_cents

end

