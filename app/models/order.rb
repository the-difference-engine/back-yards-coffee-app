class Order < ApplicationRecord
  has_many :carted_products
end
