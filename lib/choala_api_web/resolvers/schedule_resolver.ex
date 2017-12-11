defmodule ChoalaApiWeb.ScheduleResolver do
  alias ChoalaApi.Schedule

  def all_events(_root, _args, _info) do
    events = Schedule.list_events()
    {:ok, events}
  end

end
