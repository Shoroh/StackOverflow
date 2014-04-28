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

  describe "POST 'create'" do

    before :each do
      @user = build(:user)
    end

    it "sends new message to User Class" do
      params = {
        username: "Shoroh362",
        email:    "shoroh@gmail.com",
        password: "123456789",
        password_confirmation: "123456789"
      }
      post :create, user: params
    end


  end

end