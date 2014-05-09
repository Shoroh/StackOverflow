require "spec_helper"

feature 'Guest turns the page' do
  scenario "User clicks 'ask question' button on root page" do
    create_list(:question, 60)

    visit "/questions"

    within '.pagination' do
      click_link('2')
    end

    expect(current_path).to eq('/questions/page/2')
  end


end

