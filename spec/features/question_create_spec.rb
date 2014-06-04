require_relative 'acceptance_helper'

feature "Question create" do

  before(:each) do
    login_user_warden
  end

  scenario "User creates a new questions" do
    visit "/"
    click_link 'Ask Question'

    fill_in "Title", :with => "How to patch KDE under FreeBSD?"
    fill_in "Body", with: 'It is elementary, Watson!'
    fill_in "Tags", with: 'Tag1, tag2, tag3'
    click_button "Create Question"
    expect(@user.questions.first.title).to eq('How to patch KDE under FreeBSD?')
    expect(@user.questions.first.tag_list).to eq(['tag1', 'tag2', 'tag3'])
    have_rendered 'questions/show'
  end

end