require 'spec_helper'

describe User do
  # Create one user to check uniqueness in further
  User.create!(name: 'Steve_Jobs', email: 'Steve_Jobs@google.com', password: 'secret12', password_confirmation: 'secret12')
  it { should validate_uniqueness_of(:name) }

  it { should validate_presence_of(:name) }

  it { should ensure_length_of(:name).is_at_least(3).is_at_most(60) }

  it { should have_many(:questions) }
  it { should have_many(:answers)}
  it { should have_one(:profile) }

  # Check that user has his profile after create
  it 'should has profile after create' do
    user = create(:user, name: 'Shoroh')
    expect(user.profile.has_attribute?(:display_name)).to be_true
  end
end
