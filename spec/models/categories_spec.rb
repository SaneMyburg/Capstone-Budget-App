require 'rails_helper'

RSpec.describe Category, type: :model do
  @user = User.create(name: 'Sane', email: 'sane@gmail.com', password: 'sane123')
  subject { Category.new(user: @user, name: 'Food', icon: 'https://images.saymedia-content.com/.image/t_share/MTc0NDI3ODYxNzA3NDY2MDg4/30-foods-you-should-eat-in-kenya.jpg') }

  before { subject.save }
  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Name should contain some char' do
    subject.name = '    '
    expect(subject).to_not be_valid
  end

  it 'Icon should be present' do
    subject.icon = nil
    expect(subject).to_not be_valid
  end

  it 'Icon should contain some char' do
    subject.icon = '    '
    expect(subject).to_not be_valid
  end
end
