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
  it { should route(:get, '/questions/popular').to(controller: 'questions', action: 'popular') }
  it { should route(:get, '/questions/unanswered').to(controller: 'questions', action: 'unanswered') }


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
        @user1 = create(:user, email: 'shoroh362@gmail.com', password: 'super_secret', password_confirmation: 'super_secret')
        # sign_in_form 'shoroh362@gmail.com', 'super_secret'
        sign_in(:user, @user1)
        @question1 = create(:question, user: @user1)

        get :edit, id: @question1
      end

      it { should render_template('edit') }

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq @question1
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

      let(:question_old){create(:question, user: @user)}

      context 'with valid attributes' do
        it 'assigns the requested question to @question' do
          patch :update, id: question_old, question: attributes_for(:question), format: :js
          expect(assigns(:question)).to eq question_old
        end

        it 'changes question attributes' do
          patch :update, id: question_old, question: attributes_for(:question, body: 'New edition of old question'), format: :js
          question_old.reload
          expect(question_old.body).to eq('New edition of old question')
        end
      end

      context 'with User is not authorized' do
        it 're-render template' do
          logout_user
          patch :update, id: question_old, question: attributes_for(:question), format: :js
          expect(assigns(:question)).to_not eq question_old
        end
      end
    end
  end
end
