class Product < ApplicationRecord
  belongs_to :user

  has_many :product_orders
  has_many :orders, through: :product_orders
  has_many_attached :photos
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :condition, presence: true
  validates :size, presence: true
  validates :payment_option, inclusion: { in: ["Card Payment", "Cash Payment"]}
  validates :stripe_plan_name, presence: true
  monetize :price_cents
  validates :delivery_option, inclusion: { in: ["Collect from chosen location", "Deliver Home", "Arrange pick-up"]}
end
