json.status :success
json.data do
  json.extract! news, :id, :title, :author, :created_at, :updated_at
  json.thumbnail news.thumbnail(request)
  json.source news.source(request)
end
