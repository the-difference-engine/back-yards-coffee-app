require 'administrate/base_dashboard'

class WholesalerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    customer: Field::BelongsTo,
    id: Field::Number,
    business_name: Field::String,
    contact_name: Field::String,
    title: Field::String,
    work_phone: Field::String,
    alternate_phone: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    billing_address: Field::String,
    billing_city: Field::String,
    billing_state: Field::String,
    billing_zip_code: Field::String,
    shipping_address: Field::String,
    shipping_city: Field::String,
    shipping_state: Field::String,
    shipping_zip_code: Field::String,
    website: Field::String,
    accounts_payable_contact_name: Field::String,
    accounts_payable_contact_email: Field::String,
    accounts_payable_contact_phone: Field::String,
    retailer: Field::Boolean,
    tax_exempt: Field::Boolean,
    delivery_instructions: Field::String,
    recieving_hours: Field::String,
    days_closed: Field::String,
    is_approved: Field::Boolean,
    is_rejected: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :customer,
    :id,
    :business_name,
    :contact_name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :customer,
    :id,
    :business_name,
    :contact_name,
    :title,
    :work_phone,
    :alternate_phone,
    :created_at,
    :updated_at,
    :billing_address,
    :billing_city,
    :billing_state,
    :billing_zip_code,
    :shipping_address,
    :shipping_city,
    :shipping_state,
    :shipping_zip_code,
    :website,
    :accounts_payable_contact_name,
    :accounts_payable_contact_email,
    :accounts_payable_contact_phone,
    :retailer,
    :tax_exempt,
    :delivery_instructions,
    :recieving_hours,
    :days_closed,
    :is_approved,
    :is_rejected
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :customer,
    :business_name,
    :contact_name,
    :title,
    :work_phone,
    :alternate_phone,
    :billing_address,
    :billing_city,
    :billing_state,
    :billing_zip_code,
    :shipping_address,
    :shipping_city,
    :shipping_state,
    :shipping_zip_code,
    :website,
    :accounts_payable_contact_name,
    :accounts_payable_contact_email,
    :accounts_payable_contact_phone,
    :retailer,
    :tax_exempt,
    :delivery_instructions,
    :recieving_hours,
    :days_closed,
    :is_approved,
    :is_rejected
  ].freeze

  # Overwrite this method to customize how wholesalers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(wholesaler)
  #   "Wholesaler ##{wholesaler.id}"
  # end
end
