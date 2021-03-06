require_relative 'acceptance_helper'

feature 'Answer Create' do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}

  scenario 'Registered User creates answer', js: true do
    sign_in_form(user.email, user.password)
    visit question_path(question)

    fill_in 'Your answer', with: "I have an answer. But I won't tell you."
    click_on 'Create Answer'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content "I have an answer. But I won't tell you."
    end
  end

  scenario 'Registered User tries to create invalid answer', js: true do
    sign_in_form(user.email, user.password)
    visit question_path(question)

    click_on 'Create Answer'

    expect(current_path).to eq question_path(question)

    within '.has-error' do
      expect(page).to have_content "can't be blank"
    end

    fill_in 'Your answer', with: "I"
    click_on 'Create Answer'

    within '.has-error' do
      expect(page).to have_content "is too short (minimum is 3 characters)"
    end
  end
end