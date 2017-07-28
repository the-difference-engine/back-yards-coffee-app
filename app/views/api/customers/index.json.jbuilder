json.array! @customers.each do |customer|
  json.id customer.id
  json.email customer.email
end