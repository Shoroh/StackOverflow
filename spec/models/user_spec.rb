require 'spec_helper'

describe User do
  # Create one user to check uniqueness in further
  User.create!(name: 'Steve_Jobs', email: 'Steve_Jobs@google.com', password: 'secret12', password_confirmation: 'secret12')
  it { should validate_uniqueness_of(:name) }

  it { should validate_presence_of(:name) }

  it { should ensure_length_of(:name).is_at_least(3).is_at_most(90) }

  it { should have_many(:questions) }
  it { should have_many(:answers)}
  it { should have_many(:votes)}
  it { should have_one(:profile) }

  it { should allow_value('Jim_Carry').for(:name) }
  # it { should_not allow_value("@#!,. '|'").for(:name) }

  # Check that user has his profile after create
  it 'should has profile after create' do
    user = create(:user, name: 'Shoroh')
    expect(user.profile.has_attribute?(:display_name)).to be_true
  end

  describe '.find_for_oauth' do
    let!(:user) {create(:user)}
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    context 'user already has authorization' do
      it 'returns the user' do
        user.identities.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'useralready exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }, extra: { raw_info: { name: user.name }} ) }

        it 'does not create new user' do
          expect {User.find_for_oauth(auth)}.to_not change(User, :count)
        end

        it 'creates authorization for user' do
          expect {User.find_for_oauth(auth)}.to change(user.identities, :count).by(1)
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end
    end
  end

  User.first.destroy!

end
