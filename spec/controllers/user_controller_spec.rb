require 'spec_helper'

describe Devise::RegistrationsController do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET 'New'" do

    let(:user){mock_model("User").as_new_record}

    before do
      expect(User).to receive(:new).and_return(user)
      get :new
    end

    it "renders new template" do
      expect(response).to render_template :new
    end

    it "assigns @user variable to the view" do
      expect(assigns[:user]).to eq(user)
    end

  end


end