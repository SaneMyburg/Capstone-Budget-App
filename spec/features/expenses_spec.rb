require 'rails_helper'

RSpec.feature 'Expenses Page', type: :feature do
  include Devise::Test::IntegrationHelpers

    let(:user) { User.create!(name: 'Sandy', email: 'sandy@gmail.com', password: 'sane123') }

    icon_class = Category::ICONS.first[:class]
    let!(:category) { Category.create!(user: user, name: 'Journey', icon: icon_class) }
    let!(:expense) { Expense.create!(user: user, name: 'France', amount: 583.15) }

    before do
      user.confirm
      sign_in user
      category.expenses << expense 
    end

    scenario 'User can see the list of expenses' do
      visit category_expenses_path(category)
      expect(page).to have_content('Expenses')
      expect(page).to have_content('France')
      expect(page).to have_content('$583.15')
    end

  # scenario 'User can see the list of operations' do
  #   click_link 'Add a new expense'
  #   expect(page).to have_content('Name')
  #   expect(page).to have_content('Amount')
  # end

  # scenario 'User can add a new expense' do
  #   click_link 'Add a new expense'
  #   fill_in 'expense_name', with: 'Germany'
  #   fill_in 'expense_amount', with: '750.50'
  #   click_button 'Save'

  #   expect(current_path).to eq category_expenses_path(category)
  #   expect(page).to have_content('Germany')
  #   expect(page).to have_content('750.50')
  # end
end
