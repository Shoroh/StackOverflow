require 'spec_helper'

describe CommentsController do
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }

  describe 'POST #create' do
    context 'with User is authorized' do
      before do
        login_user
      end

      context 'with valid attributes' do
        it 'saves a new comment to the database' do
          expect { xhr :post, :create, comment: attributes_for(:comment), user_id: @user.id, commentable_id: question.id, commentable_type: 'Question' }.to change(question.comments, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not save a new comment' do
          expect { xhr :post, :create, comment: attributes_for(:invalid_comment), user_id: @user.id, commentable_id: question.id, commentable_type: 'Question' }.to_not change(Answer, :count)
        end
      end

      context 'with User is not authorized' do
        it 'redirect to user sign in view' do
          expect { xhr :post, :create, comment: attributes_for(:invalid_comment), user_id: nil, commentable_id: question.id, commentable_type: 'Question' }.to_not change(Answer, :count)
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'with User is authorized' do
      before do
        login_user
      end

      let(:comment){create(:comment, commentable_id: answer.id, commentable_type: 'Answer', user: @user)}

      context 'with valid attributes' do
        it 'assigns the requested comment to @comment' do
          patch :update, id: comment, comment: attributes_for(:comment), format: :js
          expect(assigns(:comment)).to eq comment
        end

        it 'changes comment attributes' do
          patch :update, id: comment, comment: attributes_for(:comment, body: 'New edition'), format: :js
          comment.reload
          expect(comment.body).to eq('New edition')
        end
      end

      context 'with User is not authorized' do
        it 're-render template' do
          logout_user
          patch :update, id: comment, comment: attributes_for(:comment), format: :js
          expect(assigns(:comment)).to_not eq comment
        end
      end
    end
  end
end
