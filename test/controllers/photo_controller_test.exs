defmodule Chronos.PhotoControllerTest do
  use Chronos.ConnCase

  alias Chronos.Photo
  @valid_attrs %{event_id: "some content", s3_url: "some content", uploader: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, photo_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing photos"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, photo_path(conn, :new)
    assert html_response(conn, 200) =~ "New photo"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, photo_path(conn, :create), photo: @valid_attrs
    assert redirected_to(conn) == photo_path(conn, :index)
    assert Repo.get_by(Photo, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, photo_path(conn, :create), photo: @invalid_attrs
    assert html_response(conn, 200) =~ "New photo"
  end

  test "shows chosen resource", %{conn: conn} do
    photo = Repo.insert! %Photo{}
    conn = get conn, photo_path(conn, :show, photo)
    assert html_response(conn, 200) =~ "Show photo"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, photo_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    photo = Repo.insert! %Photo{}
    conn = get conn, photo_path(conn, :edit, photo)
    assert html_response(conn, 200) =~ "Edit photo"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    photo = Repo.insert! %Photo{}
    conn = put conn, photo_path(conn, :update, photo), photo: @valid_attrs
    assert redirected_to(conn) == photo_path(conn, :show, photo)
    assert Repo.get_by(Photo, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    photo = Repo.insert! %Photo{}
    conn = put conn, photo_path(conn, :update, photo), photo: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit photo"
  end

  test "deletes chosen resource", %{conn: conn} do
    photo = Repo.insert! %Photo{}
    conn = delete conn, photo_path(conn, :delete, photo)
    assert redirected_to(conn) == photo_path(conn, :index)
    refute Repo.get(Photo, photo.id)
  end
end
