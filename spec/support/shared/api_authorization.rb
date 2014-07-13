shared_examples_for "API Authenticable" do
  context 'unAuthorized' do
    it 'returns 401 status code when is no access token' do
      do_request
      expect(response.status).to eq 401
    end

    it 'returns 401 status code when access token is invalid' do
      do_request(access_token: '1234')
      expect(response.status).to eq 401
    end
  end
end
