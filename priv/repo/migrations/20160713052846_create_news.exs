defmodule Scanner.Repo.Migrations.CreateNews do
  use Ecto.Migration

  def change do
    create table(:news) do
      add :content, :text
      add :title, :string
      add :subtitle, :string
      add :author, :string
      add :thumbnail_url, :string
      add :source_url, :string

      add :type, :string

      timestamps()
    end

  end
end
