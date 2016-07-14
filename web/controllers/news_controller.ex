defmodule Scanner.NewsController do
  use Scanner.Web, :controller

  alias Scanner.News

  plug :fetch_all_news when action == :index
  plug :fetch_one_news when action in [:edit, :update]

  def index conn, params do
    conn
    |> render("index.html")
  end

  def edit conn, params do
    conn
    |> render("edit.html")
  end

  def fetch_all_news conn, _options do
    params = conn.params
    page = if params["page"], do: String.to_integer(params["page"]), else: 1
    offset = (page - 1) * 10
    query =
      if type = params["type"] do
        from n in News, where: n.type == ^type
      else
        News
      end

    query =
      if search = params["search"] do
        from n in query, where: like(n.title, ^("%#{search}%")) or like(n.subtitle, ^("%#{search}%")) or like(n.author, ^("%#{search}%"))
      else
        query
      end

    news = Repo.all(from n in query, limit: 10, offset: ^offset)
    count = Repo.one(from n in query, select: count("id"))
    finished = count <= offset + 10

    conn
    |> assign(:news, news)
    |> assign(:start, offset)
    |> assign(:stop, if(finished, do: count, else: offset + 10))
    |> assign(:total, count)
    |> assign(:page, page)
    |> assign(:finished, finished)
  end

  def fetch_one_news conn, _options do
    id = String.to_integer(conn.params["id"])
    news = Repo.get(News, id)

    conn
    |> assign(:id, id)
    |> assign(:news, news)
  end
end
