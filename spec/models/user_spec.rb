require 'spec_helper'

describe User do

  let(:user){User.new}

  it "is an ActiveRecord Model" do
    expect(User.superclass).to eq(ActiveRecord::Base)
  end

  it "has email" do
    user.email = "shoroh362@gmail.com"
    expect(user.email).to eq("shoroh362@gmail.com")
  end

  it "has username" do
    user.username = "Shoroh"
    expect(user.username).to eq("Shoroh")
  end

  it "has password" do
    user.password = "12345678"
    expect(user.password).to eq("12345678")
  end

  it "has password confirmation" do
    user.password_confirmation = "12345678"
    expect(user.password_confirmation).to eq("12345678")
  end

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username) }

end
