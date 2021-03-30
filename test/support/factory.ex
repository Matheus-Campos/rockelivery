defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      address: "Rua dos mafagafos, 22",
      age: 22,
      cep: "12345678",
      cpf: "12345678900",
      email: "silva.campos.matheus@gmail.com",
      password: "123456",
      name: "Matheus Campos"
    }
  end

  def user_factory do
    %User{
      address: "Rua dos mafagafos, 22",
      age: 22,
      cep: "12345678",
      cpf: "12345678900",
      email: "silva.campos.matheus@gmail.com",
      password: "123456",
      name: "Matheus Campos",
      id: "ff6ceccd-9fe0-4582-8ac7-93ae76239133"
    }
  end
end
