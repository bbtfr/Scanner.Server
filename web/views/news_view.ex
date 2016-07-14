defmodule Scanner.NewsView do
  use Scanner.Web, :view

  defdelegate active_when(conn, query, result \\ ~s(class="active")), to: Scanner.LayoutView
  defdelegate pagination_numbers(offset, total), to: Scanner.LayoutView
  defdelegate highlight(text, keyword), to: Scanner.LayoutView
end
