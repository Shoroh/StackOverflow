require 'spec_helper'

describe ProfilesController do
  let!(:user) {create(:user)}
  let!(:user_profile) {create(:profile, user_id: user.id)}

  describe "GET #show" do
    before {get :show, user_id: user.id}

    it 'assigns the requested profile to @profile' do
      expect(assigns(:profile)).to eq user_profile
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end