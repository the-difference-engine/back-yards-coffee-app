include ActionView::Helpers::NumberHelper
module StripeTool

  # returns the quantity for a Stripe Product object
  def self.product_quantity(product)
    product.skus.data[0].inventory.quantity + 1
  end

  def self.subscriptions(subscriptions, prod_id)
    freq = {"Weekly" => 1, "Bimonthly" => 2, "Monthly" => 3}
    subs = subscriptions.data.select{|subscription| subscription.metadata.prod_id == prod_id }
    subs.sort!{|a,b| freq[a.metadata.frequency] <=> freq[b.metadata.frequency] }
    subs.map{|sub| "#{sub.metadata.frequency} / #{number_to_currency(sub.amount.to_f / 100)} per bag" }
  end

end
