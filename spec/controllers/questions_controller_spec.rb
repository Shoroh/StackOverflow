require 'spec_helper'

describe QuestionsController do
  let(:question) {create(:question)}

  describe 'GET #index' do
    let(:questions) {create_list(:question, 3)}

    before {get :index}

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before {get :show, id: question}

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'with User is authorized' do
      before do
        login_user
        get :new
      end

      it 'assigns a new Question to @question' do
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'with User is not authorized' do
      it 'redirect to user sign in view' do
        get :new
        expect(response).to require_login
      end
    end
  end

  describe 'GET #edit' do
    context 'with User is authorized' do
      before do
        login_user
        get :edit, id: question
      end

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'with User is not authorized' do
      it 'redirect to user sign in view' do
        get :edit, id: question
        expect(response).to require_login
      end
    end
  end

  describe 'POST #create' do
    context 'with User is authorized' do
      before do
        login_user
      end

      context 'with valid attributes' do
        it 'saves a new question in the database' do
         expect {post :create, question: attributes_for(:question)}.to change(Question, :count).by(1)
        end

        it 'redirect to the show view' do
          post :create, question: attributes_for(:question)
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'with invalid attributes' do
        it 'does not save a new question' do
          expect {post :create, question: attributes_for(:invalid_question)}.to_not change(Question, :count)
        end

        it 're-renders new view' do
          post :create, question: attributes_for(:invalid_question)
          expect(response).to render_template :new
        end
      end
    end

    context 'with User is not authorized' do
      it 'redirect to user sign in view' do
        post :create, question: attributes_for(:question)
        expect(response).to require_login
      end
    end
  end

  describe 'PATCH #update' do
    context 'with User is authorized' do
      before do
        login_user
      end

      context 'with valid attributes' do
        it 'assigns the requested question to @question' do
          patch :update, id: question, question: attributes_for(:question)
          expect(assigns(:question)).to eq question
        end

        it 'changes question attributes' do
          patch :update, id: question, question: { title: 'new title', body: 'new body' }
          question.reload
          expect(question.title).to eq('new title')
          expect(question.body).to eq('new body')
        end

        it 'redirect to updated question view' do
          patch :update, id: question, question: { title: 'new title', body: 'new body' }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'with invalid attributes' do
        let(:old_question){question}
        before {patch :update, id: question, question: { title: 'new title', body: nil }}

        it 'does not change question attributes' do
          question.reload
          expect(question.title).to eq(old_question.title)
          expect(question.body).to eq(old_question.body)
        end

        it 're-renders new view' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'with User is not authorized' do
      it 'redirect to user sign in view' do
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
        expect(response).to require_login
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with User is authorized' do
      before do
        login_user
        question
      end

      it 'deletes question' do
        expect {delete :destroy, id: question}.to change(Question, :count).by(-1)
      end

      it 'redirects to back' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end

    context 'with User is not authorized' do
      it 'redirect to user sign in view' do
        delete :destroy, id: question
        expect(response).to require_login
      end
    end
  end

end
