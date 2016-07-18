json.status :success
json.page @page
json.per @per
json.finished @finished
json.data(@news) do |news|
  json.extract! news, :id, :title, :author
  json.created_at l(news.created_at, format: :long)
  json.updated_at l(news.updated_at, format: :long)
  json.thumbnail news.thumbnail(request)
  json.source news.source(request)
end
