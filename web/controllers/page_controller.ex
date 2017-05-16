defmodule Chronos.PageController do
  use Chronos.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Chronos.AuthHandler

  def index(conn, _params) do
    render conn, "index.html", user: Guardian.Plug.current_resource(conn)
  end
end
