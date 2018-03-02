FactoryGirl.define do
  factory :address, class: Hash do
    line1 '1234 Main street'
    line2 nil
    city 'Anytown'
    state 'CA'
    postal_code '123456'
    country 'US'
    initialize_with { attributes }
  end
  factory :shipping, class: Hash do
    name 'Jenny Rosen'
    address { build(:address) }
    initialize_with { attributes }
  end
  factory :package_dimensions, class: Hash do
    height 10.0
    length 3.0
    weight 16.0
    width 5.0
    initialize_with { attributes }
  end
  factory :sku_product, class: Hash do
    id 'prod_blah_blah'
    package_dimensions { build(:package_dimensions) }
    initialize_with { attributes }
  end
  factory :item_parent, class: Hash do
    id 'sku_blah_blah'
    package_dimensions nil
    product { build(:sku_product) }
    initialize_with { attributes }
  end
  factory :item, class: Hash do
    amount 4200
    currency 'usd'
    parent { build(:item_parent) }
    initialize_with { attributes }
  end
  factory :stripe_order, class: Hash do
    id 'fake_order_id'
    items { build_list(:item, 1) }
    shipping { build(:address) }
    charge nil
    initialize_with { attributes }
  end
  factory :stripe_callback, class: Hash do
    order { build(:stripe_order) }
    initialize_with { attributes }
  end
end
