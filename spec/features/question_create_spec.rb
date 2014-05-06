require "spec_helper"

feature "Question create" do

  before(:each) do
    login_user_warden
  end

  scenario "User clicks 'ask question' button on root page" do
    visit "/"
    click_link 'Ask Question'
  end

  scenario "User creates a new questions" do
    visit new_question_path

    fill_in "Title", :with => "How to patch KDE under FreeBSD?"
    fill_in "Body", with: 'It is elementary, Watson!'
    fill_in "Tags", with: 'Tag1, tag2, tag3'
    click_button "Create Question"
    expect(@user.questions.first.title).to eq('How to patch KDE under FreeBSD?')
    expect(@user.questions.first.tag_list).to eq(['tag1', 'tag2', 'tag3'])
    user_sees_alert 'Question was successfully created!'
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