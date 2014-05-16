require 'spec_helper'

feature 'Answer Edit' do

  given(:user) {create(:user)}
  given(:user2) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, question: question, user: user)}

  describe "Registered User" do

    background do
      sign_in_form(user.email, user.password)
      visit question_path(question)
    end

    scenario 'Registered User edits his answer', js: true do

      within "#item-answer-#{answer.id}" do
        find(:css, "a[href='/questions/#{question.id}/answers/#{answer.id}/edit']").click
      end

      within "#item-answer-#{answer.id}" do
        fill_in 'Your answer', with: "New title for old question."
        click_on 'Update Answer'
      end

      within '.answers' do
        expect(page).to have_content "New title for old question."
      end
    end

    scenario 'Registered User edits his answer with invalid data', js: true do

      within "#item-answer-#{answer.id}" do
        find(:css, "a[href='/questions/#{question.id}/answers/#{answer.id}/edit']").click
      end

      within "#item-answer-#{answer.id}" do
        fill_in 'Your answer', with: "2"
        click_on 'Update Answer'
      end

      expect(page).to have_content "is too short (minimum is 3 characters)"
    end
  end

  scenario 'Registered User tries to edit not his answer', js: true do
    sign_in_form(user2.email, user2.password)
    visit question_path(question)
    expect(page).to_not have_selector('.answer_edit_icon')
  end

  scenario 'Unregistered User tries to edit some answer', js: true do
    answer = create(:answer, question: question, user: user)
    visit question_path(question)

    expect(page).to_not have_link "Edit"
  end
end