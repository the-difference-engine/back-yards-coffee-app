class Customer < ApplicationRecord
  has_many :orders
  has_many :carted_products
  has_many :carted_subscriptions
  has_one :wholesaler

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
      line2: address2,
      city: city,
      state: state,
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

  def address_validation_response
    begin
      address_to = Shippo::Address.create(
        name: full_name,
        street1: address,
        street2: address2,
        city: city,
        state: state,
        zip: zip_code,
        country: 'US',
        validate: true
      )
    rescue
      p ' ******** SHIPPO API ERROR ********* '
      return 'Sorry, Try Again'
    end
    address_to
  end

  def valid_shipping_address?
    begin
      address_to = Shippo::Address.create(
        name: full_name,
        street1: address,
        street2: address2,
        city: city,
        state: state,
        zip: zip_code,
        country: 'US',
        validate: true
      )
    rescue
      p ' ******** SHIPPO API ERROR ********* '
      return false
    end
    p address_to
    address_to.validation_results.is_valid
  end

  def carted_items
    # products = carted_products.where(status: 'carted')
    #   .map do |o|
    #     {
    #       type: 'sku',
    #       parent: o.sku,
    #       quantity: o.quantity
    #     }
    #   end
    quantities = Hash.new(0)
    carted_products.where(status: 'carted').each do |product|
      quantities[product.sku] += product.quantity
    end
    current_subscription.products['items'].each do |product|
      quantities[product['parent']] += product['quantity']
    end
    quantities.map do |sku, quantity|
      {
        type: 'sku',
        parent: sku,
        quantity: quantity
      }
    end
  end

  def carted_products_and_subscription_quantity
    product_quantity = carted_products.where(status: 'carted').map(&:quantity)&.sum || 0
    subscription_quantity = current_subscription.status == 'pending' ? current_subscription.quantity : 0
    product_quantity + subscription_quantity
  end

  def current_subscription
    @subscriptions = carted_subscriptions.order(created_at: :desc)
    if @subscriptions.length.zero? || @subscriptions.first.status == 'inactive'
      return carted_subscriptions.create
    end
    @subscriptions.first
  end
end
