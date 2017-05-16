defmodule Chronos.Repo.Migrations.CreatePhoto do
  use Ecto.Migration

  def change do
    create table(:photos, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :event_id, :uuid, null: false
      add :uploader, :string, null: false
      add :s3_url, :string, null: false

      timestamps()
    end

  end
end
