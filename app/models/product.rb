class Product < ApplicationRecord
  belongs_to :user

  has_many :product_orders
  has_many :orders, through: :product_orders
  has_many_attached :photos
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?
  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :condition, presence: true
  validates :size, presence: true
  monetize :price_cents
end
