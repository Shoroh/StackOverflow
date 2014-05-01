require "spec_helper"

feature "Question" do

  before(:each) do
    login_user_warden
  end

  scenario "User see 'ask question' button on root page" do
    visit "/"
    expect(page).to have_link 'Ask Question'
  end

  scenario "User creates a new questions" do
    visit new_question_path

    fill_in "Title", :with => "My Question"
    fill_in "Body", with: 'How to patch KDE under freeBSD?'
    click_button "Create Question"
    expect(@user.questions.first.title).to eq('My Question')
    expect(page).to have_css '.alert', text: 'Question was successfully created!'
  end

  scenario "User click to Questions link and get index of questions page" do
    visit "/"
    click_link "Questions"

    expect(page).to have_title 'Recent Questions'
  end

  scenario "User see quantity of questions in DB at sidebar" do
    visit "/questions"
    expect(page).to have_css "#questions-count"
  end

end