require 'spec_helper'

describe 'Question API' do
  let!(:question){ create(:question) }

  it_behaves_like "API Authenticable"

  describe "Create new Question" do
    let!(:me){ create(:user) }
    let!(:access_token){ create(:access_token, resource_owner_id: me.id) }

    it "create" do
      new_question = build(:question, user: me)
      post 'api/v1/questions', title: new_question.title, body: new_question.body, access_token:access_token.token

      %w[title body].each do |attr|
        expect(response.body).to be_json_eql(new_question.send(attr.to_sym).to_json).at_path("#{attr}")
      end
    end

    def do_request(options = {})
      post "api/v1/questions/", {format: :json}.merge(options)
    end
  end

  describe 'GET one' do
    it_behaves_like "API Authenticable"

    context 'Authorized' do
      let(:access_token){ create(:access_token) }
      let!(:answers){ create_list(:answer, 5, question: question) }
      let!(:comments){ create_list(:comment, 5, commentable: question) }

      before do
        get "api/v1/questions/#{question.id}", format: :json, access_token: access_token.token
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      %w[id title body created_at updated_at].each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("question/#{attr}")
        end
      end

      context 'answers' do
        it 'question includes answer' do
          expect(response.body).to have_json_size(5).at_path("question/answers")
        end

        %w[id body created_at updated_at].each do |attr|
          it "answer object contains #{attr}" do
            expect(response.body).to be_json_eql(answers.first.send(attr.to_sym).to_json).at_path("question/answers/0/#{attr}")
          end
        end
      end
      it_behaves_like "Commentable"
    end
  end
  def do_request(options = {})
    get "api/v1/questions/#{question.id}", {format: :json}.merge(options)
  end

  def commentable
    "question/comments"
  end
end