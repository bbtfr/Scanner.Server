defmodule Scanner.JSONHelper do
  defmacro __using__ _opts do
    quote do
      def json_success conn, data do
        conn
        |> json(Map.merge(data, %{status: :success}))
      end

      def json_failed conn, status, message do
        conn
        |> put_status(status)
        |> json(%{status: :failed, message: message})
        |> halt
      end
    end
  end
end
