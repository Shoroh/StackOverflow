require_relative 'acceptance_helper'

feature "Registered User could attach file to his question" do

  background do
    login_user_warden
  end

  scenario "User attaches file when asks a question" do
    visit new_question_path

    fill_in "Title", :with => "How to patch KDE under FreeBSD?"
    fill_in "Body", with: 'It is elementary, Watson!'

    attach_file "File", "#{Rails.root}/spec/spec_helper.rb"

    click_button "Create Question"

    expect(page).to have_content "spec_helper.rb"
  end

end