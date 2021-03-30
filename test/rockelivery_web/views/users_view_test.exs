defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory
  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created",
             user: %Rockelivery.User{
               address: "Rua dos mafagafos, 22",
               age: 22,
               cep: "12345678",
               cpf: "12345678900",
               email: "silva.campos.matheus@gmail.com",
               id: "ff6ceccd-9fe0-4582-8ac7-93ae76239133",
               inserted_at: nil,
               name: "Matheus Campos",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } == response
  end
end
