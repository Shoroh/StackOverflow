require "spec_helper"

feature "Question" do

  scenario "User see 'ask question' button on root page" do
    visit "/"
    expect(page).to have_link 'Ask Question'
  end

  scenario "User didn't see 'ask question' button on questions#new page" do
    visit "/questions/new"
    expect(page).not_to have_link 'Ask Question'
  end

  scenario "User creates a new questions" do
    visit "/questions/new"

    fill_in "Title", :with => "My Question"
    fill_in "Body", with: 'How to patch KDE under freeBSD?'
    click_button "Create Question"
    expect(page).to have_css '.notice', text: 'Question was successfully created.'
  end

end