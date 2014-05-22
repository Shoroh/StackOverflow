require_relative 'acceptance_helper'

feature 'Sort questions on root page' do
  scenario "User clicks 'recent' button and sees recent questions" do
    old_question = create(:question)
    new_question = create(:question)
    visit '/questions'

    click_link 'Recent'

    expect(new_question.title).to appear_before(old_question.title)
    expect(page).to have_title('Recent — Stack Overflow')
  end

  scenario "User clicks 'featured' button and sees featured questions" do
    featured_questions = create_list(:featured_question, 3)
    create_list(:question, 3)
    visit '/questions'

    click_link 'Featured'

    # TODO Заменить на with_in
    expect(page.find("#question-summary-#{featured_questions.first.id}")).to have_css('.fui-heart')
    expect(page).to have_title('Featured — Stack Overflow')
  end

  scenario "User clicks 'popular' button and sees popular questions" do
    old_question = create(:question)
    new_question = create(:question)

    visit "/questions/#{old_question.id}"
    visit "/questions"

    click_link 'Popular'

    expect(old_question.title).to appear_before(new_question.title)
    expect(page).to have_title('Popular — Stack Overflow')
  end

  scenario "User clicks 'unanswered' button and sees questions without answers" do
    question_with_answer = create(:question)
    create(:answer, question: question_with_answer)
    question_without_answer = create(:question)
    visit "/questions"

    click_link 'Unanswered'

    expect(page).to have_content(question_without_answer.title)
    expect(page).to_not have_content(question_with_answer.title)
    expect(page).to have_title('Unanswered — Stack Overflow')
  end

  scenario "User selects some tag, and sees questions with this tag" do
    question_with_tag1 = create(:question, tag_list: 'tag1')
    question_with_tag2 = create(:question, tag_list: 'tag2')

    visit "/questions"

    click_link 'Tags'

    within '#tags_window' do
      click_link 'tag1'
    end

    expect(page).to have_content(question_with_tag1.title)
    expect(page).to_not have_content(question_with_tag2.title)
    expect(page).to have_title("tag1 — Stack Overflow")

    visit "/questions"

    within ".questions_block" do
      click_link 'tag2'
    end

    expect(page).to have_content(question_with_tag2.title)
    expect(page).to_not have_content(question_with_tag1.title)
    expect(page).to have_title("tag2 — Stack Overflow")
  end

end