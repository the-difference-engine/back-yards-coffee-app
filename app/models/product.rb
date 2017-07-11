class Product
  include ActiveModel::Model
  attr_accessor :name,
                :id,
                :images, 
                :description,
                :object,
                :active,
                :attributes,
                :caption,
                :created,
                :deactivate_on,
                :livemode,
                :metadata,
                :name,
                :package_dimensions,
                :shippable,
                :skus,
                :updated,
                :url

end