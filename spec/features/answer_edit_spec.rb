require 'spec_helper'

feature 'Answer Edit' do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}

  scenario 'Registered User edits his answer', js: true do
    answer = create(:answer, question: question, user: user)
    sign_in_form(user.email, user.password)
    visit question_path(question)

    within "#item-answer-#{answer.id}" do
      click_on 'Edit'
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
    answer = create(:answer, question: question, user: user)
    sign_in_form(user.email, user.password)
    visit question_path(question)

    within "#item-answer-#{answer.id}" do
      click_on 'Edit'
    end

    within "#item-answer-#{answer.id}" do
      fill_in 'Your answer', with: "2"
      click_on 'Update Answer'
    end

    expect(page).to have_content "is too short (minimum is 3 characters)"

  end
end