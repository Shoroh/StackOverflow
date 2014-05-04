require "spec_helper"

feature 'Guest turns the page' do
  scenario "User clicks 'ask question' button on root page" do
    create_list(:question, 60)

    visit "/questions"
    click_link('2')

    expect(current_path).to eq('/questions/page/2')
  end


end

