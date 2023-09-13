class Category < ApplicationRecord
  has_and_belongs_to_many :expenses
  belongs_to :user

  validates :name, presence: true, length: { in: 1..20 }
  validates :icon, presence: true

  ICONS = [
    { class: 'bi bi-briefcase', name: 'Education' },
    { class: 'bi bi-cart', name: 'Food' },
    { class: 'bi bi-house', name: 'Home' },
    { class: 'bi bi-globe2', name: 'Internet' },
    { class: 'bi bi-airplane-fill', name: 'Leisure' },
    { class: 'bi bi-heart-pulse', name: 'Medical Health' },
    { class: 'bi bi-bus-front', name: 'Transport' },
    { class: 'bi bi-bank', name: 'Saving' }
  ].freeze

  def total_expenses_amount
    expenses.sum(:amount)
  end
end
