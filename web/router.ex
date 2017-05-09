defmodule Chronos.Router do
  use Chronos.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Chronos do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/events", EventController
  end

  scope "/auth", Chronos do
    pipe_through :browser

    get "/login", AuthController, :login
    post "/login", AuthController, :login_callback

    get "/signup", AuthController, :signup
    post "/signup", AuthController, :signup_callback

    post "/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", Chronos do
  #   pipe_through :api
  # end
end
