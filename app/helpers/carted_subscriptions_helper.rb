module CartedSubscriptionsHelper
  def new_subscription_params
    {
      plan: carted_subscription_params[:plan],
      products: {
        items: [
          {
            type: 'sku',
            quantity: carted_subscription_params[:quantity],
            parent: carted_subscription_params[:sku]
          }
        ],
        items_meta: [
          {
            name: carted_subscription_params[:name],
            product_id: carted_subscription_params[:product_id]
          }
        ]
      },
      order_created_at: Date.today
    }
  end
end
