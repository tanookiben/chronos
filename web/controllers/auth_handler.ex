defmodule Chronos.AuthHandler do
  use Chronos.Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "You must be logged in to do that")
    |> redirect(to: "/auth/login")
  end

  def already_authenticated(conn, _params) do
    conn
    |> put_flash(:error, "You must be logged out to do that")
    |> redirect(to: "/")
  end
end
