require_relative 'api_dbase_helper'
require_relative '../../../spec/support/features/login_macros'

describe 'Profiles API' do
  describe 'Resource Owner Profile' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      # before :all do
      #   login_user_warden
      # end
      # let(:me){ @user }
      let(:me){ create(:user) }
      let(:access_token){ create(:access_token, resource_owner_id: me.id) }

      before do
        get 'api/v1/profiles/me', format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end

      %w[id email].each do |attr|
        it "returns user #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path("user/#{attr}")
        end
      end

      %w[password encrypted_password].each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path("user/#{attr}")
        end
      end
    end
  end
  def do_request(options = {})
    get 'api/v1/profiles/me', {format: :json}.merge(options)
  end
end