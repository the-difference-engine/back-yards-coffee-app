class OrdersController < ApplicationController
 
 def create 
  order = Stripe::Order.retrieve("cus_B5Qapeb0OBNWDh")
  
#   Stripe::Order id=or_1AjGJqD5v3nurHsLLCjyh5y9 0x00000a
#   JSON: {
#     "id": "or_1AjGJqD5v3nurHsLLCjyh5y9",
#     "object": "object",
#     "amount": 1500,
#     "amount_returned": null,
#     "application": null,
#     "application_fee": null,
#     "charge": null,
#     "created": 1500940234,
#     "currency": "usd",
#     "customer": null,
#     "email": null,
#     "items": [
#     {
#       "object": "order_item",
#       "amount": 1500,
#       "currency": "usd",
#       "description": "T-shirt",
#       "parent": "sk_1AU2CdD5v3nurHsL1ybBeRBG",
#       "quantity": null,
#       "type": "sku"
#     }
#   ],
#   "livemode": false,
#   "metadata": {
#   },
#   "returns": {
#     "object": "list",
#     "data": [

#     ],
#     "has_more": false,
#     "total_count": 0,
#     "url": "/v1/order_returns?order=or_1AjGJqD5v3nurHsLLCjyh5y9"
#   },
#   "selected_shipping_method": null,
#   "shipping": {
#     "address": {
#       "city": "Anytown",
#       "country": "US",
#       "line1": "1234 Main street",
#       "line2": null,
#       "postal_code": "123456",
#       "state": null
#     },
#     "carrier": null,
#     "name": "Jenny Rosen",
#     "phone": null,
#     "tracking_number": null
#   },
#   "shipping_methods": null,
#   "status": "created",
#   "status_transitions": {
#     "canceled": null,
#     "fulfiled": null,
#     "paid": null,
#     "returned": null
#   },
#   "updated": 1500940234
# }
  render "show.html.erb"
  end 
end