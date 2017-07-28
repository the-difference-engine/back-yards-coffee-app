class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :carted_products
  has_many :customers, through: :carted_products
end
