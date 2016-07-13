defmodule Scanner.News do
  use Scanner.Web, :model

  @derive {Poison.Encoder, only: [:content, :subtitle, :title, :author, :thumbnail_url, :source_url]}

  schema "news" do
    field :content, :string
    field :title, :string
    field :subtitle, :string
    field :author, :string
    field :thumbnail_url, :string
    field :source_url, :string

    field :type, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :title, :author, :thumbnail_url, :source_url])
    |> validate_required([:content, :title, :author, :thumbnail_url])
  end
end
