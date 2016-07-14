defmodule Scanner.LayoutView do
  use Scanner.Web, :view

  def active_when conn, query, result \\ ~s(class="active") do
    all =
      Enum.all? query, fn
        {:view, value} -> view_module(conn) == value
        {:controller, value} -> controller_module(conn) == value
        {:action, value} -> action_name(conn) == value
        {:params, value} -> Enum.all?(value, fn {key, value} -> conn.params[key] == value end)
      end

    if all, do: raw(result)
  end

  def pagination_numbers offset, total do
    window = 2

    last = round(Float.ceil(total / 10))
    last = if last == 0, do: 1, else: last

    page = round(offset / 10 + 1)

    {start, stop} =
      cond do
        page < 1 + window -> {1, 1 + 2 * window}
        page in (1 + window) .. (last - window) -> {page - window, page + window}
        page > last - window -> {last - 2 * window, last}
      end

    {start, stop, page, 1, last}
  end

  def highlight text, keyword do
    if keyword do
      raw String.replace(text, keyword, ~s(<span class="highlight">#{keyword}</span>))
    else
      text
    end
  end
end
