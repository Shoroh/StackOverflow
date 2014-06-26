require 'spec_helper'

describe 'Users Array API' do
  context 'authorized' do
    let!(:me){ create(:user) }
    let!(:user1){ create(:user) }
    let!(:user2){ create(:user) }
    let(:access_token){ create(:access_token, resource_owner_id: me.id) }

    before do
      get 'api/v1/profiles/all', format: :json, access_token: access_token.token
    end

    it 'returns 200 status code' do
      expect(response).to be_success
    end

    %w[id name].each do |attr|
      it "returns user #{attr}" do
        expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path("0/#{attr}")
      end
    end

    %w[admin email].each do |attr|
      it "does not contain #{attr}" do
        expect(response.body).to_not have_json_path("0/#{attr}")
      end
    end

    it 'returns array of users' do
      expect(response.body).to eq (User.all).to_json(except: [:admin, :email])
    end
  end
end