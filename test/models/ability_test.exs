defmodule Scanner.AbilityTest do
  use Scanner.ModelCase

  alias Scanner.Ability

  @valid_attrs %{unique_id: "some content", use_counts: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ability.changeset(%Ability{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ability.changeset(%Ability{}, @invalid_attrs)
    refute changeset.valid?
  end
end
