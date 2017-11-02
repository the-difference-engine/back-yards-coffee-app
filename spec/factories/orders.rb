FactoryGirl.define do
  factory :order do
    stripe_order_id "MyString"
    customer_id 1
  end
end
