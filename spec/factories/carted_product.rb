FactoryGirl.define do
  factory :carted_product, :class => 'CartedProduct' do
    quantity 2
    product_id 'prod_AuxRSpec01234'
    sku 'whole_bean'
    customer_id 1
    status 'carted'
  end
end