require 'spec_helper'

describe "devise/registrations/new.html.erb" do
  before do
    allow(view).to receive(:resource).and_return(User.new)
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
  end

  it "has new_user form" do
    render
    expect(rendered).to have_selector('form#new_user')
  end
end
