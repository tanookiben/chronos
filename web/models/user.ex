defmodule Chronos.User do
  use Chronos.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "users" do
    field :email, :string
    field :password, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> encrypt_password()
  end

  def encrypt_password(changeset) do
    raw = changeset.changes[:password]
    if is_nil(raw) do
      changeset
    else
      change(changeset, %{password: Comeonin.Bcrypt.hashpwsalt(raw)})
    end
  end

  def authenticate(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.password)
  end
end
