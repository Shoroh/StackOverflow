require 'spec_helper'

describe UsersController do

  let(:users) {create_list(:user, 3)}
  let(:user) {create(:user)}

  it { should route(:get, '/users').to(controller: 'users', action: 'index') }
  it { should route(:get, '/user/1').to(controller: 'users', action: 'show', id: 1) }
  it { should route(:get, '/profile/edit').to(controller: 'users', action: 'edit') }
  it { should route(:patch, '/profile/edit').to(controller: 'users', action: 'update') }

  describe 'GET #index' do

    before {get :index}

    it 'populates an array of all users' do
      expect(assigns(:users)).to match_array(users)
    end

    it { should render_template('index') }
  end

  describe "GET #show" do
    before {get :show, id: user.id}

    it 'assigns the requested user to @user' do
      expect(assigns(:user)).to eq user
    end

    it { should render_template('show') }
  end

  describe 'GET #edit' do
    context 'with User is authorized' do
      before do
        login_user
        get :edit
      end

      it { should render_template('edit') }
    end

    context 'with User is not authorized' do
      before do
        get :edit
      end
      it { should redirect_to(new_user_session_path) }
    end
  end
end