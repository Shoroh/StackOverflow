require 'spec_helper'

describe 'Profiles API' do
  describe 'Resource Owner Profile' do
    context 'unAuthorized' do
      it 'returns 401 status code when is no access token' do
        get 'api/v1/profiles/me', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code when access token is invalid' do
        get 'api/v1/profiles/me', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me){ create(:user) }
      let(:access_token){ create(:access_token, resource_owner_id: me.id) }

      before do
        get 'api/v1/profiles/me', format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      %w[id email].each do |attr|
        it "returns user #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w[password encrypted_password].each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end
  end
end