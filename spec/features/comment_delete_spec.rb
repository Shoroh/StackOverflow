require_relative 'acceptance_helper'

feature 'Delete Comment' do

  given!(:user) {create(:user)}
  given(:user2) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:comment) {create(:comment, user: user, commentable: question)}

  describe 'Registered User' do

    background do
      sign_in_form(user.email, user.password)
      visit question_path(question)
    end

    scenario 'Registered User deletes his comment', js: true do

      within ".question_show_body" do
        click_on('1 comment')

        find(:css, "a[href='/questions/#{question.id}/comments/#{comment.id}']").click

        expect(current_path).to eq question_path(question)

        within ".question_show_comments" do
          expect(page).to_not have_content("#{comment.body}")
        end
      end
    end
  end

  scenario 'Guest tries to delete some comment' do
    visit question_path(question)
    expect(page).to_not have_selector('.comment_edit_icon')
  end

  scenario 'User tries to delete not his comment' do
    sign_in_form(user2.email, user2.password)
    visit question_path(question)

    expect(page).to_not have_selector('.comment_edit_icon')
  end

end