defmodule Chronos.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :string, unique: true, null: false
      add :password, :string, null: false

      timestamps()
    end

  end
end
