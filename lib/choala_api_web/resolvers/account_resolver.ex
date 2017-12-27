defmodule ChoalaApiWeb.AccountResolver do
  alias ChoalaApi.Accounts
  alias ChoalaApi.Accounts.User
  alias ChoalaApi.Accounts.Session

  def user(_args, %{context: %{user_id: user_id}}) do
    {:ok, Accounts.get_user!(user_id)}
  end
  def user(_args, _context), do: {:ok, nil}

  def create_user(_root, args, _context) do
    case Accounts.create_user(args) do
      {:ok, user} ->
        {:ok, user}
      _err ->
        {:error, "Could not create user"}
    end
  end

  def login(_root, args, _context) do
    user = Accounts.get_by(email: args.email)
    with (%User{} = user) <- Accounts.get_by(email: args.email),
         true <- Accounts.verify_password(user, args.password),
         {:ok, %Session{auth_token: auth_token}} <- Accounts.new_session(user.id)
    do
      {:ok, %{auth_token: auth_token}}
    else
      nil -> {:error, "invalid login"}
      _ -> {:error, "invalid login"}
    end
  end

  def sign_up(_root, args, _context) do
    with {:ok, user} <- Accounts.create_user(args),
         {:ok, session} <- Accounts.new_session(user.id)
    do
      {:ok, %{auth_token: session.auth_token}}
    else
      nil -> {:error, "invalid sign up"}
      {:error, changeset} -> {:error, "invalid user details"}
      _   -> {:error, "invalid sign up"}
    end
  end

end
