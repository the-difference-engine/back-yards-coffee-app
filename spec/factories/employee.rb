FactoryGirl.define do
  factory :employee, :class => 'Employee' do
    sequence(:email){ |n| "employeedoe#{n}@example.com" }
    password '12345678'
    password_confirmation '12345678'
  end
  factory :admin, :class => 'Employee' do
    sequence(:email){ |n| "employeedoe1#{n}@example.com" }
    password '12345678'
    password_confirmation '12345678'
    admin true
  end
end