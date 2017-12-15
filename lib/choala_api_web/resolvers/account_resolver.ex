defmodule ChoalaApiWeb.AccountResolver do
  alias ChoalaApi.Accounts

  def user(_args, %{context: %{user_id: user_id}}) do
    {:ok, Accounts.get_user!(user_id)}
  end
  def user(_args, _context), do: {:ok, nil}

  def create_user(_root, args, _context) do
    case Accounts.create_user(args) do
      {:ok, event} ->
        {:ok, event}
      _err ->
        {:error, "Could not create user"}
    end
  end
end
