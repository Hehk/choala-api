defmodule ChoalaApi.Repo.Migrations.AddUserIdToEvent do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :user_id, references(:users, on_delete: :nothing) 
    end

  end
end
