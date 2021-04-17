defmodule Rockelivery.Repo.Migrations.PopulateUsersCityUf do
  use Ecto.Migration

  alias Rockelivery.{Repo, User}
  alias Rockelivery.ViaCep.Client
  alias Rockelivery.ViaCep.Response

  def up do
    User
    |> Repo.all()
    |> Enum.each(&update_city_uf/1)
  end

  def down do
    Repo.update_all(User, set: [city: nil, uf: nil])
  end

  defp update_city_uf(%User{cep: cep} = user) do
    case Client.get_cep_info(cep) do
      {:ok, %Response{} = cep_response} -> update_user(user, cep_response)
      {:error, _reason} = error -> error
    end
  end

  defp update_user(user, %Response{city: city, uf: uf}) do
    user
    |> User.changeset(%{uf: uf, city: city})
    |> Repo.update()
  end
end
