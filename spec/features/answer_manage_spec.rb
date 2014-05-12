require 'spec_helper'

feature 'Answer Create, Edit and Delete' do

  given!(:user) {create(:user)}
  given!(:question) {create(:question, user: user)}

  scenario 'Registered User creates answer', js: true do
    sign_in_form(user.email, user.password)
    visit question_path(question)

    fill_in 'Your answer', with: "I have an answer. But I won't tell you."
    click_on 'Create Answer'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content "I have an answer. But I won't tell you."
    end
    # user_sees_alert 'Answer was successfully added!'
  end

  scenario 'Registered User edits his answer', js: true do
    sign_in_form(user.email, user.password)
    visit question_path(question)

    fill_in 'Your answer', with: "I have an answer. But I won't tell you."
    click_on 'Create Answer'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content "I have an answer. But I won't tell you."
    end

    within ".answers" do
      click_on 'Edit'
    end

    within "#item-answer-#{Answer.last.id}" do
      fill_in 'Your answer', with: "New title for old question."
      click_on 'Update Answer'
    end

    within '.answers' do
      expect(page).to have_content "New title for old question."
    end

  end
end