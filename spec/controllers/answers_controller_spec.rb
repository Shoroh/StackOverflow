require 'spec_helper'

describe AnswersController do
  let(:question){create(:question)}
  it { should route(:post, "/questions/#{question.id}/answers").to(controller: 'answers', action: 'create', question_id: question.id) }

  describe 'POST #create' do
    context 'with User is authorized' do
      before do
        login_user
      end

      let(:question){create(:question)}
      context 'with valid attributes' do
        it 'saves a new answer in the database' do
          expect {post :create, answer: attributes_for(:answer), user_id: @user.id, question_id: question.id}.to change(question.answers, :count).by(1)
        end

        it 'redirect to the question view' do
          post :create, answer: attributes_for(:answer), user_id: @user.id, question_id: question.id
          expect(response).to redirect_to question_path(question)
        end
      end

      context 'with invalid attributes' do
        it 'does not save a new answer' do
          expect {post :create, answer: attributes_for(:invalid_answer), user_id: @user.id, question_id: question.id}.to_not change(Answer, :count)
        end

        it 're-renders question show page' do
          post :create, answer: attributes_for(:invalid_answer), user_id: @user.id, question_id: question.id
          expect(response).to render_template 'questions/show'
        end
      end
    end

    context 'with User is not authorized' do
      it 'redirect to user sign in view' do
        post :create, answer: attributes_for(:answer), user_id: nil, question_id: question.id
        expect(response).to require_login
      end
    end
  end


end
