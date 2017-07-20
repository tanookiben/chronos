defmodule Chronos.EventTest do
  use Chronos.ModelCase

  alias Chronos.Event

  @valid_attrs %{description: "some content", end_date: Ecto.Date.cast!("2017-01-02"), location: "some content", name: "some content", start_date: Ecto.Date.cast!("2017-01-01")}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
