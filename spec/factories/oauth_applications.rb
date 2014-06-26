FactoryGirl.define do
  factory :oauth_application, class: Doorkeeper::Application do
    name 'Test'
    redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
    # sequence(:uid) { |n| "1234567890_#{n}" }
    # sequence(:secret) { |n| "1234567890_#{n}" }
    uid '123456789'
    secret '1234567890987654321'
  end
end
