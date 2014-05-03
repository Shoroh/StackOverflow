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

  scenario "User fills his profile with valid data" do
    login_user_warden
    visit profile_path

    fill_in "Age", :with => 35
    fill_in "Display name", with: 'Homer Simpson'
    fill_in "Facebook", with: 'microgenius'
    click_button "Update Profile"

    user_sees_alert 'Profile was successfully updated!'
  end

  scenario "User fills his profile with invalid data" do
    login_user_warden
    visit profile_path

    fill_in "Age", :with => 120
    fill_in "Display name", with: 'Homer Simpson'
    fill_in "Facebook", with: 'microgenius'
    click_button "Update Profile"

    expect(page).to have_content('must be less than 100')
  end

  scenario "Guest tries to reach profile#edit page" do
    visit profile_path

    expect(page).to_not have_button('Update Profile')
  end

  scenario "User goes to edit reg data through his profile page" do
    login_user_warden
    visit profile_path

    click_link "Edit registration data"

    expect(page).to have_button('Update User')
  end

  scenario "User changes his email" do
    create(:user, name: 'shoroh', email: 'shoroh362@yandex.ru', password: 'secret12', password_confirmation: 'secret12')
    sign_in_form 'shoroh362@yandex.ru', 'secret12'

    visit edit_user_registration_path

    fill_in 'Email', :with => 'mail@microgenius.ru'
    fill_in 'Current password', :with => 'secret12'

    click_button "Update User"

    user_sees_alert 'You updated your account successfully.'
  end

  scenario "User deletes his account", :js => true do
    create(:user, name: 'shoroh362', email: 'shoroh@yandex.ru', password: 'secret12', password_confirmation: 'secret12')
    sign_in_form 'shoroh@yandex.ru', 'secret12'

    visit edit_user_registration_path

    click_on 'Unhappy?'

    click_button 'Delete my account!'

    page.driver.browser.switch_to.alert.accept

    user_sees_alert 'Bye! Your account was successfully cancelled. We hope to see you again soon.'
  end
end