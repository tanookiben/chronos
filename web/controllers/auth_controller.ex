defmodule Chronos.AuthController do
  use Chronos.Web, :controller

  plug Guardian.Plug.EnsureNotAuthenticated, handler: Chronos.PlugHandler

  alias Chronos.User

  def login(conn, _params) do
    changeset = User.changeset(%User{})
    action = auth_path(conn, :login_callback)
    render(conn, "login.html", changeset: changeset, action: action)
  end

  def login_callback(conn, %{"user" => %{"email" => email, "password" => password}}) do
    changeset = User.changeset(%User{email: email})
    query = User |> where([u], u.email == ^email)
    user = Repo.one(query)
    if is_nil(user) || !User.authenticate(user, password) do
      conn
      |> put_flash(:error, "Sorry, we weren't able to log you in")
      |> render("login.html", changeset: changeset, action: auth_path(conn, :login_callback))
    else
      conn
      |> Guardian.Plug.sign_in(user)
      |> put_flash(:info, "You have successfully logged in")
      |> redirect(to: "/")
    end
  end

  def signup(conn, _params) do
    changeset = User.changeset(%User{})
    action = auth_path(conn, :signup_callback)
    render(conn, "signup.html", changeset: changeset, action: action)
  end

  def signup_callback(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Please sign in with your new account")
        |> redirect(to: "/auth/login")
      {:error, changeset} ->
        action = auth_path(conn, :signup_callback)
        render(conn, "signup.html", changeset: changeset, action: action)
    end
  end

  def logout(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "You have successfully logged out")
    |> redirect(to: "/")
  end
end
