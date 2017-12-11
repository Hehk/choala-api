defmodule ChoalaApi.Schedule.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChoalaApi.Schedule.Event


  schema "events" do
    field :mutable, :boolean, default: false
    field :name, :string
    field :period, :integer

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:name, :period, :mutable])
    |> validate_required([:name, :period, :mutable])
  end
end
