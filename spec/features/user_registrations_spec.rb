require 'spec_helper'

feature 'User Registration' do

  context 'when visiting new user path' do

    background do
      visit new_user_registration_path
    end

    context 'registering with valid data' do

      given(:email) { 'myawesome@email.com' }

      background do
        fill_form_with_valid_data(email: email)
      end

      scenario 'new user is created' do
        expect do
          register
        end.to change(User, :count).by(1)
      end
    end

    context 'registering with invalid data' do

      given(:email) { 'asdfsdfssf' }

      background do
        fill_form_with_valid_data(email: email)
      end

      scenario 'new user is not created' do
        expect do
          register
        end.to_not change(User, :count)
      end
    end

  end

end

def fill_form_with_valid_data(args={})
  email = args.fetch(:email, 'email@example.com')
  fill_in 'user_email', with: email
  fill_in 'user_name', with: 'Andrew Sikorsky'
  fill_in 'user_password', with: 'my-super-secret-password'
  fill_in 'user_password_confirmation', with: 'my-super-secret-password'
end

def register
  click_button 'Sign up'
end