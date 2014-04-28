require 'spec_helper'

describe "devise/registrations/new.html.erb" do
  before do
    allow(view).to receive(:resource).and_return(User.new)
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
    render
  end

  it "has new_user form" do
    expect(rendered).to have_selector('form#new_user')
  end

  it "has email field" do
    expect(rendered).to have_selector('#user_email')
  end

  it "has username field" do
    expect(rendered).to have_selector('#user_username')
  end

  it "has password field" do
    expect(rendered).to have_selector('#user_password')
  end

  it "has password confirmation field" do
    expect(rendered).to have_selector('#user_password_confirmation')
  end

  it "has sign up button" do
    expect(rendered).to have_button('Sign up')
  end
end
