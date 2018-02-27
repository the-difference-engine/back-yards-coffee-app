module Api
  class ShippingCallbackController < ApplicationController
    def create
      render json: {
        order_update: {
          items: [],
          shipping_methods: [
            {
              id: 'pick_up_shipping',
              amount: 0,
              currency: 'usd',
              delivery_estimate: nil,
              description: 'Pick Up'
            }
          ]
        }
      }
    end
  end
end
