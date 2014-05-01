require 'spec_helper'

describe WelcomeController do
  it { should route(:get, '/').to(controller: 'welcome', action: 'index') }

  describe "GET 'index'" do
    let(:questions) {create_list(:question, 3)}

    before {get :index}

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it { should render_template('index') }
  end

end
