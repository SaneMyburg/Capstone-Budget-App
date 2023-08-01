require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::NumberHelper

  let(:user) { User.create!(name: 'user01', email: 'user01@gmail.com', password: 'password01') }

  icon_class = Category::ICONS.first[:class]
  let(:category) { Category.create!(user:, name: 'Journey', icon: icon_class) }

  before do
    user.confirm
    sign_in user
  end

  describe 'GET /category_expenses/:id' do
    it 'should return a 200 OK status and render the expenses template' do
      expense1 = Expense.create!(user:, name: 'Expense 1', amount: 100, created_at: Time.now)
      expense2 = Expense.create!(user:, name: 'Expense 2', amount: 200, created_at: Time.now)

      category.expenses << expense1
      category.expenses << expense2

      get category_expenses_path(category)

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /new' do
    it 'should return a 200 OK status and render the new expense template' do
      get new_category_expense_path(category)

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end
end
