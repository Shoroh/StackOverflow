require_relative 'acceptance_helper'

feature 'Votes the Question' do
  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}


  scenario "Registered user votes the question", js: true do
    sign_in_form(user.email, user.password)
    visit question_path(question)

    click_on "Like it"
    expect(current_path).to eq question_path(question)
    expect(page).to have_content "Don't like it"
  end

end