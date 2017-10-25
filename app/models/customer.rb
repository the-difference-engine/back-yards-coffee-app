class Customer < ApplicationRecord

  has_many :carted_products
  has_many :carted_subscriptions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :zip_code, presence: true, on: :update

  before_create :assign_customer_id, on: :create

  def assign_customer_id
    customer = Stripe::Customer.create(email: email)
    self.stripe_customer_id = customer.id
  end

  def subscriptions_total(id)
    @customer = Stripe::Customer.retrieve(id)
    @subscriptions_total = 0
    @customer.subscriptions.data.each do |subscription|
      @subscriptions_total += (subscription.items.data[0].quantity * (subscription.items.data[0].plan.amount * 0.01))
    end
    @subscriptions_total
  end

  def self.guest_customer?(id)
    Customer.find_by(id: id)
  end

  def self.create_guest_cutomer(id)
    customer = Customer.new(id: id, email: id)
    customer.save(validate: false)
    customer
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def customer_address
    {
      line1: address,
      city: city,
      country: 'US',
      postal_code: zip_code
    }
  end

  def default_address
    {
      line1: '2059 W 47th St',
      city: 'Chicago',
      country: 'US',
      postal_code: '60609'
    }
  end

  def valid_shipping_address?
    begin
      address_to = Shippo::Address.create(
        name: full_name,
        street1: address,
        city: city,
        state: state,
        zip: zip_code,
        country: 'US',
        validate: true
      )
    rescue
      p ' ******** SHIPPO API ERRROR ********* '
      return false
    end
    address_to.validation_results.is_valid
  end

  def carted_items
    carted_products.where(status: 'carted').map { |o| { type: 'sku', parent: o.sku, quantity: o.quantity } }
  end
end
