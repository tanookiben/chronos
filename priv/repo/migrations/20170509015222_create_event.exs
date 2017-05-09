defmodule Chronos.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :start_date, :date, null: false
      add :end_date, :date
      add :description, :text
      add :location, :string

      timestamps()
    end

  end
end
