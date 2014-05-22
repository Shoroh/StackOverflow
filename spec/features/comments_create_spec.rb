require_relative 'acceptance_helper'

feature 'Create Comment' do

  given!(:user) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, user: user, question: question)}

  scenario 'Registered User creates comment for Question', js: true do
    sign_in_form(user.email, user.password)
    visit question_path(question)

    within ".question_show_body" do
      click_on('To comment')

      fill_in 'Your comment', with: "It's just a comment to question."
      click_on 'Add Comment'

      expect(current_path).to eq question_path(question)

        within ".question_show_comments" do
        expect(page).to have_content "It's just a comment to question."
      end
    end

  end

  scenario 'Registered User creates comment for Answer', js: true do
    sign_in_form(user.email, user.password)
    visit question_path(question)

    within "#item-answer-#{answer.id}" do
      click_on('To comment')

      fill_in 'Your comment', with: "It's just a comment to answer."
      click_on 'Add Comment'
    end

    expect(current_path).to eq question_path(question)

    within "#item-answer-#{answer.id}" do
      expect(page).to have_content "It's just a comment to answer."
    end

  end

  scenario 'Registered User tries to create comment for Question with invalid data', js: true do
    sign_in_form(user.email, user.password)
    visit question_path(question)

    within ".question_show_body" do
      click_on('To comment')

      fill_in 'Your comment', with: "I"
      click_on 'Add Comment'

      expect(current_path).to eq question_path(question)

      within ".has-error" do
        expect(page).to have_content "is too short (minimum is 3 characters)"
      end
    end
  end


  scenario 'Unregistered User tries to create comment', js: true do
    visit question_path(question)

    expect(page).to_not have_content "Add comment"
  end
end