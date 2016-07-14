defmodule Scanner.API.NewsController do
  use Scanner.Web, :controller
  use Scanner.JSONHelper

  alias Scanner.News

  defdelegate fetch_all_news(conn, _options), to: Scanner.NewsController
  plug :fetch_all_news when action == :index

  def index conn, params do
    %{news: news, page: page, finished: finished} = conn.assigns
    json_success conn, %{data: news, page: page, finished: finished}
  end
end
