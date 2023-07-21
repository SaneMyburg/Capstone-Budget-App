class Category < ApplicationRecord
  has_and_belongs_to_many :expenses

  validates :name, presence: true, length: { in: 1..20 }
  validates :icon, presence: true
  validates :author_id, presence: true
end
