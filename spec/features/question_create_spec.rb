require "spec_helper"

feature "Question" do

  scenario "User creates a new question" do
    visit "/question/new"

    fill_in "Title", :with => "My Question"
    fill_in "Body", with: "How to patch KDE under freeBSD?"
    click_button "Create Question"

    expect(page).to have_text("Question was successfully created.")
  end
end