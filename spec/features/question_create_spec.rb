require "spec_helper"

feature "Question" do

  scenario "User creates a new questions" do
    visit "/questions/new"

    fill_in "Title", :with => "My Question"
    fill_in "Body", with: "How to patch KDE under freeBSD?"
    click_button "Create Question"

    expect(page).to have_content 'Question was successfully created.'
  end
end