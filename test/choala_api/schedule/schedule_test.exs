defmodule ChoalaApi.ScheduleTest do
  use ChoalaApi.DataCase

  alias ChoalaApi.Schedule

  describe "events" do
    alias ChoalaApi.Schedule.Event

    @valid_attrs %{mutable: true, name: "some name", period: 42}
    @update_attrs %{mutable: false, name: "some updated name", period: 43}
    @invalid_attrs %{mutable: nil, name: nil, period: nil, user_id: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(%{email: "some email", password: "some password", name: "some name"})
        |> ChoalaApi.Accounts.create_user()

      user
    end

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_event()

      event
    end

    test "list_events/0 returns all events" do
      user = user_fixture()
      event = event_fixture(%{ user_id: user.id})
      assert Schedule.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      user = user_fixture()
      event = event_fixture(%{ user_id: user.id})
      assert Schedule.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      user = user_fixture()
      assert {:ok, %Event{} = event} = Schedule.create_event(@valid_attrs |> Enum.into(%{user_id: user.id}))
      assert event.mutable == true
      assert event.name == "some name"
      assert event.period == 42
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      user = user_fixture()
      event = event_fixture(%{ user_id: user.id })
      assert {:ok, event} = Schedule.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.mutable == false
      assert event.name == "some updated name"
      assert event.period == 43
    end

    test "update_event/2 with invalid data returns error changeset" do
      user = user_fixture()
      event = event_fixture(%{ user_id: user.id })
      assert {:error, %Ecto.Changeset{}} = Schedule.update_event(event, @invalid_attrs)
      assert event == Schedule.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      user = user_fixture()
      event = event_fixture(%{ user_id: user.id })
      assert {:ok, %Event{}} = Schedule.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      user = user_fixture()
      event = event_fixture(%{ user_id: user.id })
      assert %Ecto.Changeset{} = Schedule.change_event(event)
    end

    test "list_events/1 returns all events based on opts" do
      user = user_fixture(%{ email: "crazy unique email" })
      event_1 = event_fixture(%{ user_id: user.id })
      event_2 = event_fixture(%{ user_id: user.id })
      assert Schedule.list_events(user_id: user.id) == [event_1, event_2]

      empty_user = user_fixture(%{ email: "crazy unique email 2" })
      assert Schedule.list_events(user_id: empty_user.id) == []
    end
  end
end
