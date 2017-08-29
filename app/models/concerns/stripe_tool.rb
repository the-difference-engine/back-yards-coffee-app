include ActionView::Helpers::NumberHelper
module StripeTool

  # returns the quantity for a Stripe Product object
  def self.product_quantity(product)
    product.skus.data[0].inventory.quantity + 1
  end

  def self.product_plan_options(plans, prod_id)
    freq = {"Weekly" => 1, "Bimonthly" => 2, "Monthly" => 3}
    plan_opts = plans.data.select{|plan| plan.metadata.prod_id == prod_id }
    plan_opts.sort!{|a,b| freq[a.metadata.frequency] <=> freq[b.metadata.frequency] }
    plan_opts.map{|sub| "#{sub.metadata.frequency} / #{number_to_currency(sub.amount.to_f / 100)} per bag" }
  end

  def self.product_plans(plans, prod_id)
    plans.select{|plan| plan.metadata.prod_id == prod_id}
  end

  def self.selected_plan(plans, plan_id)
    plans.select{|plan| plan.plan_id == plan_id}
  end

end
