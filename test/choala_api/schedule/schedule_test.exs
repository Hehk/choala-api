defmodule ChoalaApi.ScheduleTest do
  use ChoalaApi.DataCase

  alias ChoalaApi.Schedule

  describe "events" do
    alias ChoalaApi.Schedule.Event

    @valid_attrs %{mutable: true, name: "some name", period: 42}
    @update_attrs %{mutable: false, name: "some updated name", period: 43}
    @invalid_attrs %{mutable: nil, name: nil, period: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Schedule.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Schedule.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Schedule.create_event(@valid_attrs)
      assert event.mutable == true
      assert event.name == "some name"
      assert event.period == 42
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = Schedule.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.mutable == false
      assert event.name == "some updated name"
      assert event.period == 43
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_event(event, @invalid_attrs)
      assert event == Schedule.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Schedule.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Schedule.change_event(event)
    end
  end
end
