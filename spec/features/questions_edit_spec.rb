require "spec_helper"

feature "Question edit" do

  scenario "User clicks 'edit question' link to go to edit his question" do
    @user1 = create(:user, email: 'shoroh362@gmail.com', password: 'super_secret', password_confirmation: 'super_secret')
    sign_in_form 'shoroh362@gmail.com', 'super_secret'
    @question1 = create(:question, user: @user1)

    visit "/questions"
    find(".edit_question_icon").click
    expect(page).to have_title("Edit — #{@question1.title} — Stack Overflow")

    fill_in 'Title', with: 'Some different title for update checking'
    click_button('Update Question')
    user_sees_alert('Question was successfully updated!')
  end


  scenario "User tries to hack — 'edit his not question' but unsuccess" do
    @user1 = create(:user, email: 'shoroh362@gmail.com', password: 'super_secret', password_confirmation: 'super_secret')
    @user2 = create(:user)
    sign_in_form 'shoroh362@gmail.com', 'super_secret'
    @question1 = create(:question, user: @user2)

    visit "/questions/#{@question1.id}/edit"
    user_sees_alert("You don't have permissions to edit this question!")
  end

end
