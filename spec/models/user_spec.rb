require 'spec_helper'

describe User do
  User.create!(name: 'asddad', email: 'asdasd@dsdasd.ru', password: 'secret12', password_confirmation: 'secret12')
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:name) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should ensure_length_of(:password).is_at_least(8) }

  it { should have_many(:questions) }
  it { should have_one(:profile) }

  it 'has profile after create' do
    user = create(:user)
    expect(user.profile.has_attribute?(:display_name)).to be_true
  end


end
