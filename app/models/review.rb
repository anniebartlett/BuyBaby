class Review < ApplicationRecord
  belongs_to :user

  validates :comment, presence: true, length: { minimum: 3 }
  validates :rating, presence: true, numericality: { only_integer: true }
end
