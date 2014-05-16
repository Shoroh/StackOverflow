include Warden::Test::Helpers

module LoginMacros

  def login_user
    @user = create(:user)
    sign_in @user
  end

  def login_user_warden
    @user = create(:user)
    login_as @user, :scope => :user
  end

  def sign_in_form(email, password)
    visit new_user_session_path
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password

    click_button 'Sign in'
  end

  def sign_out_form
    visit destroy_user_session_path
  end
end
