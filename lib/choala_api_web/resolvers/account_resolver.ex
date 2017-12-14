defmodule ChoalaApiWeb.AccountResolver do
  alias ChoalaApi.Accounts

  def user(_args, %{context: %{user_id: user_id}}) do
    {:ok, Accounts.get_user!(user_id)}
  end
  def user(_args, _context), do: {:ok, nil}
end
