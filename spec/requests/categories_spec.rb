require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'user01', email: 'user01@gmail.com', password: 'password01') }

  icon_class = Category::ICONS.first[:class]
  let(:category) { Category.create!(user:, name: 'Journey', icon: icon_class) }

  before do
    user.confirm
    sign_in user
  end

  describe 'GET /index' do
    it 'should return a 200 OK status' do
      get categories_path
      expect(response).to have_http_status(:ok)
    end

    it 'should render categories/index template' do
      get categories_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET categories expense' do
    it 'should return a 200 OK status' do
      get category_expenses_path(category)
      expect(response).to have_http_status(:ok)
    end

    it 'should render expenses template' do
      get category_expenses_path(category)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /new' do
    it 'should return a 200 OK status' do
      get new_category_path
      expect(response).to have_http_status(:ok)
    end

    it 'should render categories/new template' do
      get new_category_path
      expect(response).to render_template(:new)
    end
  end
end
