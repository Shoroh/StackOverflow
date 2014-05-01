require "spec_helper"

feature "Question" do

  before(:each) do
    login_user_warden
  end

  scenario "User clicks 'ask question' button on root page" do
    visit "/"
    click_link 'Ask Question'
  end

  scenario "User creates a new questions" do
    visit new_question_path

    fill_in "Title", :with => "My Question"
    fill_in "Body", with: 'How to patch KDE under freeBSD?'
    click_button "Create Question"
    expect(@user.questions.first.title).to eq('My Question')
    expect(page).to have_css '.alert', text: 'Question was successfully created!'
  end

  scenario "User clicks to Questions link and get index of questions page" do
    visit "/"
    click_link "Questions"

    expect(page).to have_title 'Recent Questions'
  end

  scenario "User sees quantity of questions if Questions-page" do
    visit "/questions"
    expect(page).to have_css "#questions-count"
  end

  scenario "User doesn't see quantity of questions if not Questions-page" do
    visit "/"
    expect(page).to_not have_css "#questions-count"
  end

end