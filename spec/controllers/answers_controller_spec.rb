require 'spec_helper'

describe AnswersController do
  let!(:question) { create(:question) }
  it { should route(:post, "/questions/#{question.id}/answers").to(controller: 'answers', action: 'create', question_id: question.id) }

  describe 'POST #create' do
    context 'with User is authorized' do
      before do
        login_user
      end

      context 'with valid attributes' do
        it 'saves a new answer in the database' do
          expect { xhr :post, :create, answer: attributes_for(:answer), user_id: @user.id, question_id: question.id }.to change(question.answers, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not save a new answer' do
          expect { xhr :post, :create, answer: attributes_for(:invalid_answer), user_id: @user.id, question_id: question.id }.to_not change(Answer, :count)
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

  describe 'PATCH #update' do
    context 'with User is authorized' do
      before do
        login_user
      end
      let(:answer){create(:answer, question: question, user: @user)}
      context 'with valid attributes' do
        it 'assigns the requested answer to @answer' do
          patch :update, id: answer, question_id: question.id, answer: attributes_for(:answer), format: :js
          expect(assigns(:answer)).to eq answer
        end

        it 'assigns the requested question to @question' do
          patch :update, id: answer, question_id: question.id, answer: attributes_for(:answer), format: :js
          expect(assigns(:question)).to eq question
        end

        it 'changes answer attributes' do
          patch :update, id: answer, question_id: question.id, answer: attributes_for(:answer, body: 'This is an answer'), format: :js
          answer.reload
          expect(answer.body).to eq('This is an answer')
        end
      end

      context 'with User is not authorized' do
        it 're-render template' do
          patch :update, id: answer, question_id: question.id, answer: attributes_for(:answer), format: :js
          expect(response).to render_template :update
        end
      end
    end
  end
end