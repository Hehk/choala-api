defmodule ChoalaApi.Accounts.User do
  use Ecto.Schema
  alias ChoalaApi.Accounts.User
  import Ecto.Changeset
  import Comeonin.Argon2, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :name, :string

    timestamps()
  end

  @required_fields [:name, :email, :password]
  @optional_fields []

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_length(:password, min: 8)
    |> validate_required(@required_fields)
    |> encrypt_password(attrs)
    |> unique_constraint(:email)
  end

  def encrypt_password(user, attrs) do
    case attrs[:password] do
      nil -> add_error(user, :password, "is not valid")
      password -> put_change(user, :encrypted_password, hashpwsalt(password))
    end
  end
end
