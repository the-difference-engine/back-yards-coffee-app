class Wholesaler < ApplicationRecord
  belongs_to :customer
  validates :business_name, presence: true
end
