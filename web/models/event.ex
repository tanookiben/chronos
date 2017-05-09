defmodule Chronos.Event do
  use Chronos.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "events" do
    field :name, :string
    field :start_date, :string
    field :end_date, :string
    field :description, :string
    field :location, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :start_date, :end_date, :description, :location])
    |> validate_required([:name, :start_date, :end_date, :description, :location])
  end
end
