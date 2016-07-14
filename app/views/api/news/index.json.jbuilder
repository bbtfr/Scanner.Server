json.status :success
json.page @page
json.per @per
json.finished @finished
json.data(@news) do |news|
  json.extract! news, :id, :title, :author, :created_at, :updated_at
  json.thumbnail news.thumbnail(request)
  json.source news.source(request)
end
