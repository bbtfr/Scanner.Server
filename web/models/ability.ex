defmodule Scanner.Ability do
  use Scanner.Web, :model

  schema "abilities" do
    field :unique_id, :string
    field :use_counts, :map, default: %{}

    timestamps()
  end

  @abilities ~w(scanIDCard livenessTest)

  def abilities ability do
    @abilities
    |> Enum.map(&({&1, has_ability?(ability, &1)}))
    |> Enum.into(%{})
  end

  def use_count ability, feature do
    ability.use_counts[feature] || 0
  end

  def decrease_use_count ability, feature do
    use_counts =
      ability.use_counts
      |> Map.put(feature, use_count(ability, feature) - 1)
    changeset(ability, %{use_counts: use_counts})
  end

  def has_ability? ability, feature do
    use_count(ability, feature) > 0
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset struct, params \\ %{} do
    struct
    |> cast(params, [:unique_id, :use_counts])
    |> validate_required([:unique_id, :use_counts])
  end
end
