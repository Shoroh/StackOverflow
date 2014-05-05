require 'spec_helper'

feature 'User sees stats' do

  background do
    @question = create(:question)
  end

  scenario 'Goes to root page and sees 0 views of question' do
    visit root_path

    expect(page).to have_content "Views — 0"
  end

  scenario 'Goes to questions#show page and sees 1 views' do
    visit root_path
    click_link @question.title

    expect(page).to have_content "Views by IP: 1"
  end

end