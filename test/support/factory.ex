defmodule Rockelivery.Factory do
  use ExMachina

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
end
