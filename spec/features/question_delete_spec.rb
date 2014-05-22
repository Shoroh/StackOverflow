require_relative 'acceptance_helper'

feature 'Delete Question' do

  given!(:user) {create(:user)}
  given(:user2) {create(:user)}
  given!(:question) {create(:question, user: user)}

  describe 'Registered User' do

    background do
      sign_in_form(user.email, user.password)
      visit question_path(question)
    end

    scenario 'Registered User deletes his question', js: true do

      click_on('Delete')
      page.driver.browser.switch_to.alert.accept

      expect(current_path).to eq questions_path


      expect(page).to_not have_content("#{question.title}")


      user_sees_alert 'Question was successfully deleted!'

    end
  end

end