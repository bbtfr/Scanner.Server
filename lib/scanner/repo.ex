defmodule Scanner.Repo do
  use Ecto.Repo, otp_app: :scanner

  @spec get_by_or_insert(queryable :: Ecto.Queryable.t, clauses :: Keyword.t | Map.t, opts :: Keyword.t) :: {:ok, :get, Ecto.Schema.t} | {:ok, :insert, Ecto.Schema.t} | {:error, Ecto.Changeset.t}
  def get_by_or_insert(queryable, clauses, opts \\ []) do
    case get_by(queryable, clauses, opts) do
      nil ->
        schema = struct(queryable, clauses)
        case insert(schema, opts) do
          {:ok, instance} -> {:ok, :insert, instance}
          {:error, changeset} -> {:error, changeset}
        end
      instance -> {:ok, :get, instance}
    end
  end
end
