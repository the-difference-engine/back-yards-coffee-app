require 'rails_helper'

RSpec.describe CartedSubscription, type: :model do
  xdescribe CartedSubscription do
    it 'is valid with a quantity that is more than one' do
      carted_product = build(:carted_product)
      expect(carted_product).to be_valid
    end
    it 'is invalid with a quantity of zero or less' do
      carted_product = build(:carted_product, quantity: 0)
      expect(carted_product).not_to be_valid
    end
    context "logged in as customer" do
      it 'should return the customers carted subscriptions' do
        customer = build(:customer, id: 123)
        carted_subscription = create(:carted_subscription, status: 'carted', customer_id: customer.id)
        expect(customer.carted_subscriptions.count).to eq(1)
      end
    end
    context "logged in" do
      it 'should allow a guest to add a subscriptions' do
        session_id = 543768867556
        create_list(:carted_subscription, 3, status: 'carted', customer_id: session_id)
        build(:carted_subscription, status: 'ordered', customer_id: session_id)
        expect(CartedSubscription.my_carted(session_id).count).to eq(3)
      end
    end
  end
end
