defmodule ChoalaApi.AccountsTest do
  use ChoalaApi.DataCase

  alias ChoalaApi.Accounts

  describe "users" do
    alias ChoalaApi.Accounts.User

    @valid_attrs %{email: "some email", password: "some password", name: "some name"}
    @update_attrs %{email: "some updated email", password: "some updated password", name: "some updated name"}
    @invalid_attrs %{email: nil, password: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    def user_after_changeset(user) do
      Map.put(user, :password, nil)
    end

    test "list_users/0 returns all users" do
      user = user_fixture() |> user_after_changeset()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture() |> user_after_changeset()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.encrypted_password != "some password"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture() |> user_after_changeset()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.encrypted_password != "some updated password"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture() |> user_after_changeset()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "verify_password/2 returns if password is valid" do
      user = user_fixture()
      assert Accounts.verify_password(user, "some updated password")
      assert Accounts.verify_password(user, "This is wrong")
    end
  end

  describe "sessions" do
    alias ChoalaApi.Accounts.Session

    # @valid_user %{email: "some email", password: "some password", name: "some name"}

    @valid_attrs %{auth_token: "some auth_token"}
    @update_attrs %{auth_token: "some updated auth_token"}
    @invalid_attrs %{auth_token: nil}

    def session_fixture(attrs \\ %{}) do
      user = user_fixture()
      {:ok, session} =
        %{ user_id: user.id }
        |> Enum.into(attrs)
        |> Enum.into(@valid_attrs)
        |> Accounts.create_session()

      session
    end

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Accounts.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Accounts.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      user = user_fixture()
      assert {:ok, %Session{} = session} = %{ user_id: user.id} |> Enum.into(@valid_attrs) |> Accounts.create_session()
      assert session.auth_token == "some auth_token"
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      assert {:ok, session} = Accounts.update_session(session, @update_attrs)
      assert %Session{} = session
      assert session.auth_token == "some updated auth_token"
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_session(session, @invalid_attrs)
      assert session == Accounts.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Accounts.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Accounts.change_session(session)
    end

    test "find_session/1 returns the session for given key values"  do
      session = session_fixture()
      assert session == Accounts.find_session(auth_token: session.auth_token)
    end
  end
end
