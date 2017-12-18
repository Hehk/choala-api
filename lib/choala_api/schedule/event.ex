defmodule ChoalaApi.Schedule.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChoalaApi.Schedule.Event


  schema "events" do
    field :mutable, :boolean, default: false
    field :name, :string
    field :period, :integer
    field :user_id, :id

    timestamps()
  end

  @required_fields [:name, :period, :mutable, :user_id]
  @optional_fields []

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
  end
end
