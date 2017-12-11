defmodule ChoalaApi.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :period, :integer
      add :mutable, :boolean, default: false, null: false

      timestamps()
    end

  end
end
