class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :expenses, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :name, presence: true
end
