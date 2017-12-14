defmodule ChoalaApiWeb.Schema do
  use Absinthe.Schema

  alias ChoalaApiWeb.ScheduleResolver
  alias ChoalaApiWeb.AccountResolver

  object :event do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :period, non_null(:integer)
    field :mutable, non_null(:boolean)
  end

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :name, non_null(:string)
  end

  query do
    field :all_events, non_null(list_of(non_null(:event))) do
      resolve &ScheduleResolver.all_events/3
    end

    field :user, :user do
      resolve &AccountResolver.user/2
    end
  end

  mutation do
    field :create_event, :event do
      arg :name, non_null(:string)
      arg :period, non_null(:integer)
      arg :mutable, non_null(:boolean)

      resolve &ScheduleResolver.create_event/3
    end
  end
end
