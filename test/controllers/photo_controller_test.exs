defmodule Chronos.PhotoControllerTest do
  use Chronos.ConnCase

  alias Chronos.Photo
  # @valid_attrs %{s3_path: "some content", uploader: "some content", event_id: "11111111-1111-1111-1111-111111111111"}
  # @invalid_attrs %{uploader: 1234}

  test "renders form for new resources", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    conn = guardian_login(user) |> get(photo_path(conn, :new))
    assert html_response(conn, 200) =~ "New photo"
  end

  # test "creates resource and redirects when data is valid", %{conn: conn} do
  #   {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
  #   conn = guardian_login(user) |> post(photo_path(conn, :create), photo: @valid_attrs)
  #   assert redirected_to(conn) == photo_path(conn, :index)
  #   assert Repo.get_by(Photo, @valid_attrs)
  # end

  # test "does not create resource and renders errors when data is invalid", %{conn: conn} do
  #   {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
  #   conn = guardian_login(user) |> post(photo_path(conn, :create), photo: @invalid_attrs)
  #   assert html_response(conn, 200) =~ "New photo"
  # end

  test "shows chosen resource", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    photo = Repo.insert! %Photo{s3_path: "some content", uploader: "some content", event_id: "11111111-1111-1111-1111-111111111111"}
    conn = guardian_login(user) |> get(photo_path(conn, :show, photo))
    assert html_response(conn, 200) =~ "Show photo"
  end

  test "deletes chosen resource", %{conn: conn} do
    {:ok, user} = Chronos.Repo.insert(Chronos.User.changeset(%Chronos.User{email: "email", password: "password"}))
    photo = Repo.insert! %Photo{s3_path: "some content", uploader: "some content", event_id: "11111111-1111-1111-1111-111111111111"}
    conn = guardian_login(user) |> delete(photo_path(conn, :delete, photo))
    assert redirected_to(conn) == event_path(conn, :index)
    refute Repo.get(Photo, photo.id)
  end
end
