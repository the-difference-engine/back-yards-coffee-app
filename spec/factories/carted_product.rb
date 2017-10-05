FactoryGirl.define do
  factory :carted_product, :class => 'CartedProduct' do
    quantity 2
    product_id 'prod_AphnLr8LOmFgb8'
    sku 'sku_B1KPc4HwjF9Aop'
    customer_id 1
    status 'carted'
    name '47th Street Blend'
    price 1099
  end
end