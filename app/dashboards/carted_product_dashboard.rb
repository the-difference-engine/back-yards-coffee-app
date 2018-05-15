require "administrate/base_dashboard"

class CartedProductDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    customer: Field::BelongsTo,
    order: Field::BelongsTo,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    product_id: Field::String,
    quantity: Field::Number,
    status: Field::String,
    grind_id: Field::Number,
    sku: Field::String,
    name: Field::String,
    price: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :customer,
    :order,
    :id,
    :created_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :customer,
    :order,
    :id,
    :created_at,
    :updated_at,
    :product_id,
    :quantity,
    :status,
    :grind_id,
    :sku,
    :name,
    :price,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :customer,
    :order,
    :product_id,
    :quantity,
    :status,
    :grind_id,
    :sku,
    :name,
    :price,
  ].freeze

  # Overwrite this method to customize how carted products are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(carted_product)
  #   "CartedProduct ##{carted_product.id}"
  # end
end
