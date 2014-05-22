require_relative 'acceptance_helper'

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

      # TODO Убрать проверку базы и записывать в одну строку, заменить экспект на сообщения и возможность залогинится.
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
  fill_in 'Email', with: email
  fill_in 'Name', with: 'AndrewSikorsky'
  fill_in 'Password', with: 'my-super-secret-password'
  fill_in 'Password confirmation', with: 'my-super-secret-password'
end

def register
  click_button 'Sign up'
end