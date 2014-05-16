require 'spec_helper'

feature 'Edit Comment' do

  given!(:user) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:comment) {create(:comment, user: user, commentable: question)}

  scenario 'Registered User edits his comment', js: true do
    sign_in_form(user.email, user.password)
    visit question_path(question)

    within ".question_show_body" do
      click_on('1 comment')

      click_on('Edit')

      fill_in 'Edit your comment', with: "It's just a new version of old comment to question."
      click_on 'Update Comment'

      expect(current_path).to eq question_path(question)

      within ".question_show_comments" do
        expect(page).to have_content "It's just a new version of old comment to question."
      end
    end

  end

end