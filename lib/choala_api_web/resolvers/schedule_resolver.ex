defmodule ChoalaApiWeb.ScheduleResolver do
  alias ChoalaApi.Schedule

  def all_events(_root, _args, _info) do
    events = Schedule.list_events()
    {:ok, events}
  end

  def create_event(_root, args, _info) do
    case Schedule.create_event(args) do
      {:ok, event} ->
        {:ok, event}
      _err ->
        {:error, "Could not create event"}
    end
  end

end
