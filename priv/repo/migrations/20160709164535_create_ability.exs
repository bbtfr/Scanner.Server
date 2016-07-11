defmodule Scanner.Repo.Migrations.CreateAbility do
  use Ecto.Migration

  def change do
    create table(:abilities) do
      add :unique_id, :string
      add :use_counts, :map

      timestamps()
    end

    create index(:abilities, [:unique_id], unique: true)

  end
end
