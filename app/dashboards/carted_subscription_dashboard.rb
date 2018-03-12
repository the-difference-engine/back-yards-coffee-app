require "administrate/base_dashboard"

class CartedSubscriptionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    customer: Field::BelongsTo,
    id: Field::Number,
    quantity: Field::Number,
    plan_id: Field::String,
    status: Field::String,
    grind: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    amount: Field::Number,
    interval: Field::String,
    interval_count: Field::Number,
    plan_name: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :customer,
    :id,
    :quantity,
    :plan_id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :customer,
    :id,
    :quantity,
    :plan_id,
    :status,
    :grind,
    :created_at,
    :updated_at,
    :amount,
    :interval,
    :interval_count,
    :plan_name,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :customer,
    :quantity,
    :plan_id,
    :status,
    :grind,
    :amount,
    :interval,
    :interval_count,
    :plan_name,
  ].freeze

  # Overwrite this method to customize how carted subscriptions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(carted_subscription)
  #   "CartedSubscription ##{carted_subscription.id}"
  # end
end
