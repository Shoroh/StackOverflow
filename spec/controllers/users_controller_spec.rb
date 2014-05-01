require 'spec_helper'

describe UsersController do
  let(:users) {create_list(:user, 3)}
  let(:user) {create(:user)}

  describe 'GET #index' do

    before {get :index}

    it 'populates an array of all users' do
      expect(assigns(:users)).to match_array(users)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before {get :show, id: user.id}

    it 'assigns the requested user to @user' do
      expect(assigns(:user)).to eq user
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    context 'with User is authorized' do
      before do
        login_user
        get :edit
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'with User is not authorized' do
      it 'redirect to sign in page' do
        get :edit
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end