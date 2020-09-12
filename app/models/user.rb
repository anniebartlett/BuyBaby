class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_favoritor
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  #validates :nickname, presence: true, uniqueness: true
  #validates :description, presence: true
end
