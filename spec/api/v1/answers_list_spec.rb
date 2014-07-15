require 'spec_helper'

describe 'Answers List API' do
  let!(:question){ create(:question) }
  let!(:answers){ create_list(:answer, 5, question: question) }
  describe 'GET LIST' do
    it_behaves_like "API Authenticable"

    context 'Authorized' do
      let(:access_token){ create(:access_token) }

      before do
        get "api/v1/questions/#{question.id}/answers/", format: :json, access_token: access_token.token
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(5).at_path("answers")
      end

      %w[id body created_at updated_at].each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(answers.first.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end

    end
  end
  def do_request(options = {})
    get "api/v1/questions/#{question.id}/answers/", {format: :json}.merge(options)
  end

end