require 'spec_helper'

describe QuestionsController do

  it { should route(:get, '/questions').to(controller: 'questions', action: 'index') }
  it { should route(:get, '/questions/1').to(controller: 'questions', action: 'show', id: 1) }
  it { should route(:get, '/questions/1/edit').to(controller: 'questions', action: 'edit', id: 1) }
  it { should route(:get, '/questions/new').to(controller: 'questions', action: 'new') }
  it { should route(:delete, '/questions/1').to(controller: 'questions', action: 'destroy', id: 1) }
  it { should route(:patch, '/questions/1').to(controller: 'questions', action: 'update', id: 1) }
  it { should route(:post, '/questions').to(controller: 'questions', action: 'create') }
  it { should route(:get, '/questions/featured').to(controller: 'questions', action: 'featured') }

  let(:question) {create(:question)}

  describe 'GET #index' do
    let(:questions) {create_list(:question, 3)}

    before {get :index}

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it { should render_template('index') }
  end

  describe 'GET #featured' do
    let(:questions) {create_list(:featured_question, 3)}

    before do
      create_list(:question, 3)
      get :featured
    end

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it { should render_template('index') }
  end

  describe "GET #show" do
    before {get :show, id: question}

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'increment unique_views counter from 0 to 1' do
      expect(assigns(:question).impressionist_count).to eq(1)
    end

    it { should render_template('show') }
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

      it { should render_template('new') }
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

      it { should render_template('edit') }
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
          patch :update, id: question, question: { title: 'How to patch KDE under FreeBSD?', body: 'It is elementary, Watson!' }
          question.reload
          expect(question.title).to eq('How to patch KDE under FreeBSD?')
          expect(question.body).to eq('It is elementary, Watson!')
        end

        it 'redirect to updated question view' do
          patch :update, id: question, question: { title: 'How to patch KDE under FreeBSD?', body: 'It is elementary, Watson!' }
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

        it { should render_template('edit') }
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
