defmodule Chronos.Photo do
  use Chronos.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "photos" do
    field :event_id, :string
    field :uploader, :string
    field :s3_url, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:event_id, :uploader, :s3_url])
    |> validate_required([:event_id, :uploader, :s3_url])
  end
end
