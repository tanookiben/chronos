defmodule Chronos.EventControllerTest do
  use Chronos.ConnCase

  alias Chronos.Event
  @valid_attrs %{description: "some content", end_date: Ecto.Date.cast!("2017-01-02"), location: "some content", name: "some content", start_date: Ecto.Date.cast!("2017-01-01")}
  @invalid_attrs %{name: 1234}

  test "lists all entries on index", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    conn = guardian_login(user) |> get(event_path(conn, :index))
    assert html_response(conn, 200) =~ "Listing events"
  end

  test "renders form for new resources", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    conn = guardian_login(user) |> get(event_path(conn, :new))
    assert html_response(conn, 200) =~ "New event"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    conn = guardian_login(user) |> post(event_path(conn, :create), event: @valid_attrs)
    assert redirected_to(conn) == event_path(conn, :index)
    assert Repo.get_by(Event, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    conn = guardian_login(user) |> post(event_path(conn, :create), event: @invalid_attrs)
    assert html_response(conn, 200) =~ "New event"
  end

  test "shows chosen resource", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    event = Repo.insert! %Event{description: "some content", end_date: Ecto.Date.cast!("2017-01-02"), location: "some content", name: "some content", start_date: Ecto.Date.cast!("2017-01-01")}
    conn = guardian_login(user) |> get(event_path(conn, :show, event))
    assert html_response(conn, 200) =~ "Show event"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    event = Repo.insert! %Event{description: "some content", end_date: Ecto.Date.cast!("2017-01-02"), location: "some content", name: "some content", start_date: Ecto.Date.cast!("2017-01-01")}
    conn = guardian_login(user) |> get(event_path(conn, :edit, event))
    assert html_response(conn, 200) =~ "Edit event"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    event = Repo.insert! %Event{description: "some content", end_date: Ecto.Date.cast!("2017-01-02"), location: "some content", name: "some content", start_date: Ecto.Date.cast!("2017-01-01")}
    conn = guardian_login(user) |> put(event_path(conn, :update, event), event: @valid_attrs)
    assert redirected_to(conn) == event_path(conn, :show, event)
    assert Repo.get_by(Event, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    event = Repo.insert! %Event{description: "some content", end_date: Ecto.Date.cast!("2017-01-02"), location: "some content", name: "some content", start_date: Ecto.Date.cast!("2017-01-01")}
    conn = guardian_login(user) |> put(event_path(conn, :update, event), event: @invalid_attrs)
    assert html_response(conn, 200) =~ "Edit event"
  end

  test "deletes chosen resource", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    event = Repo.insert! %Event{description: "some content", end_date: Ecto.Date.cast!("2017-01-02"), location: "some content", name: "some content", start_date: Ecto.Date.cast!("2017-01-01")}
    conn = guardian_login(user) |> delete(event_path(conn, :delete, event))
    assert redirected_to(conn) == event_path(conn, :index)
    refute Repo.get(Event, event.id)
  end
end
