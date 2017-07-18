json.array! @employees.each do |employee|
  json.id employee.id
  json.email employee.email
end