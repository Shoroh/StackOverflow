require 'spec_helper'

feature 'Create Comment to Question' do

  given!(:user) {create(:user)}
  given!(:question) {create(:question, user: user)}

  scenario 'Registered User creates coment', js: true do
    sign_in_form(user.email, user.password)
    visit question_path(question)

    within ".question_show_body" do
      click_on('To comment')

      fill_in 'Your comment', with: "It's just a comment to question."
      click_on 'Add comment'

      expect(current_path).to eq question_path(question)

        within ".question_show_comments" do
        expect(page).to have_content "It's just a comment to question."
      end
      # user_sees_alert 'Answer was successfully added!'
    end

  end

end