require 'spec_helper'

feature 'User profiles' do
  background do
    @user1 = create(:user)
    @user2 = create(:user)
    visit users_path
  end

  scenario 'sees list of registered users' do
    expect(page).to have_link(@user1.name)
    expect(page).to have_link(@user2.name)
  end

  scenario "guest clicks to user's link" do
    click_link @user1.name
    expect(page).to have_content @user1.profile.display_name
  end
end