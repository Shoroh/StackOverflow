require 'spec_helper'

describe 'Question API' do
  describe 'GET List' do
    it_behaves_like "API Authenticable"

    context 'Authorized' do
      let!(:questions){ create_list(:question, 2) }
      let(:question){ questions.last }
      let(:access_token){ create(:access_token) }
      let!(:answer){ create(:answer, question: question) }

      before do
        get 'api/v1/questions', format: :json, access_token: access_token.token
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2).at_path("questions/")
      end

      %w[id title body created_at updated_at].each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end

      it 'contains timestamp' do
        expect(response.body).to be_json_eql(questions.last.created_at.to_json).at_path('meta/timestamp')
      end

    end
  end

  def do_request(options = {})
    get 'api/v1/questions', {format: :json}.merge(options)
  end
end