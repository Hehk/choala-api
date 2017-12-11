defmodule ChoalaApiWeb.Schema do
  use Absinthe.Schema

  alias ChoalaApiWeb.ScheduleResolver

  object :event do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :period, non_null(:integer)
    field :mutable, non_null(:boolean)
  end

  query do
    field :all_events, non_null(list_of(non_null(:event))) do
      resolve &ScheduleResolver.all_events/3
    end
  end
end
