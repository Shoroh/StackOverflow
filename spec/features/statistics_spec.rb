require 'spec_helper'

feature 'User sees stats' do

  background do
    @question = create(:question)
  end

  scenario 'Goes to root page and sees 0 views of question' do
    visit root_path

    within '.views' do
      expect(page).to have_content "0"
    end

  end

  scenario 'Goes to questions#show page and sees 1 views' do
    visit root_path
    click_link @question.title
    within ".meta" do
      expect(page).to have_content "1"
    end
  end

end