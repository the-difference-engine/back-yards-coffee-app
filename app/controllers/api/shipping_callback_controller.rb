module Api
  class ShippingCallbackController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
      items = []
      shippo = ShippoService.new(items: items)
      pickup = {
        id: 'pick_up_shipping',
        amount: 0,
        currency: 'usd',
        delivery_estimate: nil,
        description: 'Pick Up'
      }
      shipping_methods = shippo.create_shipment
      shipping_methods.unshift(pickup)
      render json: {
        order_update: {
          items: [],
          shipping_methods: shipping_methods
        }
      }
    end
  end
end
