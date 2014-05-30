require 'spec_helper'

describe OmniauthCallbacksController do
  def stub_env_for_omniauth(provider = "facebook", uid = "3456", email = "test@test.com", name = "Ivan Ivanov")
    request.env["devise.mapping"] = Devise.mappings[:user]
    init = {"omniauth.auth" => { provider: provider, uid: uid, info: { email: email }, extra: {raw_info: { name: name}}}}
    env = OmniAuth::AuthHash.new(init)
    @controller.stub(:env).and_return(env)
  end
  describe "facebook" do
    before :each do
      stub_env_for_omniauth("facebook")
    end
    it "Create user" do
      get :facebook
      expect(Identity.first.uid).to eq "3456"
    end
  end
end