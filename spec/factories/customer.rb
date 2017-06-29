FactoryGirl.define do
  factory :customer, :class => 'Customer' do
    sequence(:email){ |n| "janedoe#{n}@example.com" }
    password '12345678'
    password_confirmation '12345678'
  end
end