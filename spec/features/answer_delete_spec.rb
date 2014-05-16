require 'spec_helper'

feature 'Answer Delete' do

  given(:user) {create(:user)}
  given(:user2) {create(:user)}
  given!(:question) {create(:question, user: user)}

  scenario 'Registered User deletes his answer', js: true do
    answer = create(:answer, question: question, user: user)
    sign_in_form(user.email, user.password)
    visit question_path(question)


    within ".answers" do
      find(:css, "a[href='/questions/#{question.id}/answers/#{answer.id}']").click
    end

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to_not have_content "I have an answer. But I won't tell you."
    end
  end

  scenario 'Some guest cannot to delete not his answer' do
    create(:answer, question: question, user: user)
    visit question_path(question)
    expect(page).to_not have_selector('answer_delete_icon')
  end

  scenario 'Registered User tries to delete not his answer', js: true do
    create(:answer, question: question, user: user)
    sign_in_form(user2.email, user2.password)
    visit question_path(question)
    expect(page).to_not have_selector('answer_delete_icon')
  end

end