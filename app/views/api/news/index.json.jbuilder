json.status :success
json.page @page
json.per @per
json.finished @finished
json.data(@news) do |news|
  json.extract! news, :id, :author, :title
  json.created_at l(news.created_at, format: :date)
  json.updated_at l(news.updated_at, format: :date)
  json.thumbnail news.thumbnail(request)
  json.source news.source(request)
end
