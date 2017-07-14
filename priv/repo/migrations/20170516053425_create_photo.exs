defmodule Chronos.Repo.Migrations.CreatePhoto do
  use Ecto.Migration

  def change do
    create table(:photos, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :event_id, :binary_id, null: false
      add :uploader, :string, null: false
      add :s3_path, :string, null: false

      timestamps()
    end

  end
end
