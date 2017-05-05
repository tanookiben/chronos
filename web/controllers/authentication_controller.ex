defmodule Chronos.AuthenticationController do
  use Chronos.Web, :controller

  alias Chronos.User

  def login(conn, _params) do
    render(conn, "login.html", changeset: User.changeset(%User{}), action: authentication_path(conn, :login_callback))
  end

  def login_callback(conn, params) do
    redirect(conn, to: "/")
  end

  def signup(conn, _params) do
    render(conn, "login.html", changeset: User.changeset(%User{}), action: authentication_path(conn, :signup_callback))
  end

  def signup_callback(conn, params) do
    redirect(conn, to: "/")
  end
end
