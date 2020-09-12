class Product < ApplicationRecord
  belongs_to :user

  include PgSearch::Model
  pg_search_scope :search_by_product,
                  against: [ :name, :description, :location, :category],
                  using: {
                    tsearch: { prefix: true }
                  }

  DELIVERY_OPTIONS = ["Collect from chosen location", "Deliver Home", "Arrange pick-up"]
  PAYMENT_OPTIONS = ["Card Payment", "Cash Payment"]

  acts_as_favoritable

  has_many :product_orders
  has_many :orders, through: :product_orders
  has_many :users, through: :orders
  has_many_attached :photos
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?
  # validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :location, presence: true
  validates :colour, presence: true
  # validates :longitude, presence: true
  # validates :latitude, presence: true
  validates :condition, presence: true
  validates :size, presence: true
  # validates :payment_options, inclusion: { in: PAYMENT_OPTIONS }
  # validates :deliver_option, inclusion: { in: DELIVERY_OPTIONS }
  # validates :stripe_plan_name, presence: true
  monetize :price_cents
end
