defmodule ChoalaApiWeb.Router do
  use ChoalaApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ChoalaApiWeb.Context
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ChoalaApiWeb.Schema,
      interface: :simple,
      context: %{pubsub: ChoalaApiWeb.Endpoint}
  end
end
