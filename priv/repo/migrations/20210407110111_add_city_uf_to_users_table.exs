defmodule Rockelivery.Repo.Migrations.AddCityUfToUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :city, :string
      add :uf, :string, size: 2
    end
  end
end
