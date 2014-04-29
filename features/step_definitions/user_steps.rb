Given(/^I am a guest$/) do

end

When(/^I fill the registering form with valid data$/) do
  visit("users/sign_up")
  fill_in "user_name", with: "Shoroh"
  fill_in "user_email", with: "shoroh123@gmail.com"
  fill_in "user_password", with: "12345678"
  fill_in "user_password_confirmation", with: "12345678"
  click_on 'Sign up'
end

Then(/^I should be registered in application$/) do
  expect(User.find_by_email("shoroh123@gmail.com")).not_to be_nil
end