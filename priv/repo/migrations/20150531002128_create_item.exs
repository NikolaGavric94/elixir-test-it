defmodule Infinityloop.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :id_analyze, :string
      add :content, :string

      timestamps
    end

  end
end
