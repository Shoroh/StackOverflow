require_relative 'acceptance_helper'

feature "Registered User could attach file to his answer" do

  background do
    login_user_warden
  end
  given!(:question){create(:question)}

  scenario "User attaches file when give an answer" do
    visit question_path(question)

    within ".answer_body" do
      fill_in "Your answer", with: 'It is elementary, Watson!'

      attach_file "File", "#{Rails.root}/spec/spec_helper.rb"

      click_button "Create Answer"
    end
    within '.answers' do
      expect(page).to have_link "spec_helper.rb", href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end