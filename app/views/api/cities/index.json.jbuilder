json.status :success
json.data(@cities) do |city|
  json.extract! city, :id, :name
end
