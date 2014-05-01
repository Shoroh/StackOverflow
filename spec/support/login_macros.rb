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


end
