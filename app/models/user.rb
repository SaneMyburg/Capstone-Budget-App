class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :expenses, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :name, presence: true
end
