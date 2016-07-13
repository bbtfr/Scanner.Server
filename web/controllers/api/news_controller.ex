defmodule Scanner.API.NewsController do
  use Scanner.Web, :controller
  use Scanner.JSONHelper

  alias Scanner.News

  def index conn, params do
    page = if params["page"], do: String.to_integer(params["page"]), else: 1
    offset = (page - 1) * 10
    finished = Repo.one(from n in News, select: count("id")) <= offset + 10
    query =
      if params["type"] do
        from n in News, where: n.type == ^params["type"]
      else
        News
      end

    news = Repo.all(from n in query, limit: 10, offset: ^offset)
    json_success conn, %{data: news, page: page, finished: finished}
  end
end
