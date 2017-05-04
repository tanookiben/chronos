defmodule Chronos.PageController do
  use Chronos.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
