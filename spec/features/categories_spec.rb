require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::NumberHelper
  let(:user) { User.create!(name: 'user01', email: 'user01@gmail.com', password: 'password01') }

  icon_class = Category::ICONS.first[:class]
  let!(:category) { Category.create!(user:, name: 'Journey', icon: icon_class) }

  before do
    user.confirm
    sign_in user
  end

  scenario 'User visits the categories index page' do
    visit categories_path
    expect(page).to have_content('Categories')
    expect(page).to have_content('Journey')
    click_link 'Add a new category'
    expect(page).to have_current_path(new_category_path)
  end

  scenario 'User can see total amount of each category' do
    visit categories_path
    expect(page).to have_css('.category-list', wait: 5)
    within('.category-list') do
      expect(page).to have_content(number_to_currency(category.total_expenses_amount))
    end
  end
end

RSpec.feature 'Categories', type: :feature do
  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::NumberHelper
  let(:user) { User.create!(name: 'user01', email: 'user01@gmail.com', password: 'password01') }

  icon_class = Category::ICONS.first[:class]
  let!(:category) { Category.create!(user:, name: 'Journey', icon: icon_class) }

  before do
    user.confirm
    sign_in user
    visit categories_path
  end

  scenario 'User can navigate to expenses page' do
    expect(page).to have_css('.category-list', wait: 5)
    within('.category-list') do
      expect(page).to have_content(number_to_currency(category.total_expenses_amount))
      click_link category.name
    end
  end

  scenario 'User can navigate to category/new page' do
    click_link 'Add a new category'
    expect(current_path).to eq new_category_path
  end

  scenario 'User can add new category' do
    click_link 'Add a new category'
    fill_in 'category_name', with: 'School'
    click_button 'Save'
    expect(current_path).to eq categories_path
    expect(page).to have_content('School')
    expect(page).to have_content('0.00')
  end
end
