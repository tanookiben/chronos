defmodule Chronos.Router do
  use Chronos.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Chronos do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
  end

  scope "/auth", Chronos do
    pipe_through :browser

    get "/login", AuthenticationController, :login
    post "/login", AuthenticationController, :login_callback
    get "/signup", AuthenticationController, :signup
    post "/signup", AuthenticationController, :signup_callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Chronos do
  #   pipe_through :api
  # end
end
