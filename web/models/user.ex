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
    hashed = if is_nil(params["password"]) do
      params
    else
      encrypt_password(params)
    end

    struct
    |> cast(hashed, [:email, :password])
    |> validate_required([:email, :password])
  end

  def encrypt_password(params) do
    %{params | "password" => Comeonin.Bcrypt.hashpwsalt(params["password"])}
  end
end
