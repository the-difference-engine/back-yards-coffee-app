FactoryGirl.define do
  factory :menu, :class => 'Menu' do
    name 'CoffeeHouse'
    menu_id "TestString"
    description 'example2'
    price 2.00
    category_id 3
  end
end