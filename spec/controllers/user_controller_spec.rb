require 'spec_helper'

describe Devise::RegistrationsController do

  let(:user){mock_model("User").as_new_record}

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    allow(User).to receive(:new).and_return(user)
    get :new
  end

  describe "GET 'New'" do
    it "assigns @user variable to the view" do
      expect(assigns[:user]).to eq(user)
    end

    it "renders new template" do
      expect(response).to render_template :new
    end
  end

end