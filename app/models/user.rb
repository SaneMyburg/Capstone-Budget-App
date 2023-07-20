class User < ApplicationRecord
  has_many :expenses
  has_many :categories

  validates :name, presence: true
end