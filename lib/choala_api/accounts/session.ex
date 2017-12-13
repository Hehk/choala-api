defmodule ChoalaApi.Accounts.Session do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChoalaApi.Accounts.Session


  schema "sessions" do
    field :auth_token, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Session{} = session, attrs) do
    session
    |> cast(attrs, [:auth_token, :user_id])
    |> validate_required([:auth_token, :user_id])
  end
end
