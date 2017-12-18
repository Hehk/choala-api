defmodule ChoalaApiWeb.ScheduleResolver do
  alias ChoalaApi.Schedule

  def all_events(_root, _args, %{context: %{user_id: user_id}}) do
    events = Schedule.list_events(user_id: user_id)
    {:ok, events}
  end

  def create_event(_root, args, %{context: %{user_id: user_id}}) do
    case args |> Enum.into(%{user_id: user_id}) |> Schedule.create_event() do
      {:ok, event} ->
        {:ok, event}
      _err ->
        {:error, "Could not create event"}
    end
  end

end
