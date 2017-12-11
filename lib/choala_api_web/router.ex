defmodule ChoalaApiWeb.Router do
  use ChoalaApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ChoalaApiWeb do
    pipe_through :api
  end
end
