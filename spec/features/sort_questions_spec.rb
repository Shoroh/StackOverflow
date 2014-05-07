require 'spec_helper'

feature 'Sort questions on root page' do
  scenario "User clicks 'recent' button and sees recent questions" do
    old_question = create(:question)
    new_question = create(:question)
    visit '/questions'

    click_link 'Recent'

    expect(new_question.title).to appear_before(old_question.title)
    expect(page).to have_title('Recent Questions — Stack Overflow')
  end

  scenario "User clicks 'featured' button and sees featured questions" do
    featured_questions = create_list(:featured_question, 3)
    create_list(:question, 3)
    visit '/questions'

    click_link 'Featured'

    # TODO Заменить на with_in
    expect(page.find("#question-summary-#{featured_questions.first.id}")).to have_css('.fui-heart')
    expect(page).to have_title('Featured Questions — Stack Overflow')
  end

  scenario "User clicks 'popular' button and sees popular questions" do
    old_question = create(:question)
    new_question = create(:question)

    visit "/questions/#{old_question.id}"
    visit "/questions"

    click_link 'Popular'

    expect(old_question.title).to appear_before(new_question.title)
    expect(page).to have_title('Popular Questions — Stack Overflow')
  end

end