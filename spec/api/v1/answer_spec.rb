require 'spec_helper'

describe 'Answer API' do
  let!(:question){ create(:question) }
  let!(:answer){ create(:answer, question: question) }

  describe "Create new Question" do
    let!(:me){ create(:user) }
    let!(:access_token){ create(:access_token, resource_owner_id: me.id) }

    it "create" do
      expect {post "api/v1/questions/#{question.id}/answers", answer: {body: "It's just a new_question.body"}, \
      access_token:access_token.token}.to change(Answer, :count).by(1)
    end
  end

  describe 'GET one' do
    it_behaves_like "API Authenticable"

    context 'Authorized' do
      let(:access_token){ create(:access_token) }
      let!(:comments){ create_list(:comment, 5, commentable: answer) }

      before do
        get "api/v1/questions/#{question.id}/answers/#{answer.id}", format: :json, access_token: access_token.token
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      %w[id body created_at updated_at].each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
        end
      end

      it_behaves_like "Commentable"
    end
  end
  def do_request(options = {})
    get "api/v1/questions/#{question.id}/answers/#{answer.id}", {format: :json}.merge(options)
  end

  def commentable
    "answer/comments"
  end
end