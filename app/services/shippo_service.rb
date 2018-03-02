class ShippoService
  def initialize(options = {})
    @items = options.fetch(:items, [])
  end

  def create_shipment
    [fake_shipping_option]
  end

  def fake_shipping_option
    {
      id: 'gobledegook',
      amount: 1000,
      currency: 'usd',
      delivery_estimate: nil,
      description: 'USPS Fixed Rate Fake'
    }
  end
end
