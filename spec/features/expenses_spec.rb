require 'rails_helper'

RSpec.feature 'Expenses Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'Sandy', email: 'sandy@gmail.com', password: 'sane123') }
  icon_class = Category::ICONS.first[:class]
  let!(:category) { Category.create!(user:, name: 'Journey', icon: icon_class) }
  let(:expense) { Expense.create!(user:, name: 'France', amount: 583.15) }

  before do
    user.confirm
    sign_in user
    category.expenses << expense
    visit category_expenses_path(category)
  end

  scenario 'User can see the list of expenses' do
    expect(page).to have_content('Expenses')
    expect(page).to have_content('France')
    expect(page).to have_content('$583.15')
  end

  scenario 'User can see the list of operations' do
    click_link 'Add a new expense'
    expect(page).to have_css('.new_expense_form', wait: 10)
    within('.new_expense_form') do
      expect(page).to have_content('New Expense')
      expect(find('input[name="expense[name]"]')[:placeholder]).to eq('Expense Name')
      expect(find('input[name="expense[amount]"]')[:placeholder]).to eq('Amount')
    end
  end
end

RSpec.feature 'Expenses Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'Sandy', email: 'sandy@gmail.com', password: 'sane123') }
  icon_class = Category::ICONS.first[:class]
  let!(:category) { Category.create!(user:, name: 'Journey', icon: icon_class) }
  let(:expense) { Expense.create!(user:, name: 'France', amount: 583.15) }

  before do
    user.confirm
    sign_in user
    category.expenses << expense
    visit category_expenses_path(category)
  end

  scenario 'User can add a new expense' do
    click_link 'Add a new expense'
    fill_in 'expense_name', with: 'Germany'
    fill_in 'expense_amount', with: '750.50'
    click_button 'Save'

    expect(current_path).to eq category_expenses_path(category)
    expect(page).to have_content('Germany')
    expect(page).to have_content('750.50')
  end
end
