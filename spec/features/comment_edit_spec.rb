require_relative 'acceptance_helper'

feature 'Edit Comment' do

  given!(:user) {create(:user)}
  given(:user2) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:comment) {create(:comment, user: user, commentable: question)}

  describe 'Registered User' do

    background do
      sign_in_form(user.email, user.password)
      visit question_path(question)
    end

    scenario 'Registered User edits his comment', js: true do

      within ".question_show_body" do
        click_on('1 comment')

        find(:css, "a[href='/questions/#{question.id}/comments/#{comment.id}/edit']").click

        within ".edit_comment" do
          fill_in 'Edit your comment', with: "It's just a new version of old comment to question."
          click_on 'Update Comment'
        end


        expect(current_path).to eq question_path(question)

        within ".question_show_comments" do
          expect(page).to have_content "It's just a new version of old comment to question."
        end
      end
    end

    scenario 'Registered User edits his comment with invalid data', js: true do

      within ".question_show_body" do
        click_on('1 comment')

        find(:css, "a[href='/questions/#{question.id}/comments/#{comment.id}/edit']").click

        within ".edit_comment" do
          fill_in 'Edit your comment', with: "I"
          click_on 'Update Comment'
        end
        expect(current_path).to eq question_path(question)

        within ".question_show_comments" do
          expect(page).to have_content "is too short (minimum is 3 characters)"
        end
      end
    end
  end

  scenario 'Guest tries to edit some comment' do
    visit question_path(question)
    expect(page).to_not have_selector('.comment_edit_icon')
  end

  scenario 'User tries to edit not his comment' do
    sign_in_form(user2.email, user2.password)
    visit question_path(question)

    expect(page).to_not have_selector('.comment_edit_icon')
  end

end