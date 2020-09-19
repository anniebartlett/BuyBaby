class Product < ApplicationRecord
  belongs_to :user

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_product,
                  against: [ :name, :description, :address, :category, :sale_type],
                  using: {
                    tsearch: { prefix: true }
                  }

  DELIVERY_OPTIONS = ["Collect from chosen location", "Deliver Home", "Arrange pick-up"]
  PAYMENT_OPTIONS = ["Card Payment", "Cash Payment"]
  SALE_TYPE = ["Sell", "Swap"]

  acts_as_favoritable

  has_many :product_orders, dependent: :destroy
  has_many :orders, through: :product_orders, dependent: :destroy
  has_many :users, through: :orders
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :address, presence: true
  validates :colour, presence: true
  validates :condition, presence: true
  validates :size, presence: true
  validates :sale_type, presence: true, inclusion: { in: SALE_TYPE }
  # validates :payment_options, inclusion: { in: PAYMENT_OPTIONS }
  # validates :deliver_option, inclusion: { in: DELIVERY_OPTIONS }
  # validates :stripe_plan_name, presence: true
  monetize :price_cents
end
