Given(/^I am a guest$/) do

end

When(/^I fill the registering form with valid data$/) do
  visit("/register")
  fill_in "user_username", with: "Shoroh"
  fill_in "user_email", with: "shoroh362@gmail.com"
  fill_in "user_password", with: "12345678"
  fill_in "user_password_confirmation", with: "12345678"
  click_on 'Sign up'
end

Then(/^I should be registered in application$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be logged in$/) do
  pending # express the regexp above with the code you wish you had
end