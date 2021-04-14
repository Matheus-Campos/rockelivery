defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory
  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "asdasdasd"

    response = render(UsersView, "create.json", user: user, token: token)

    expected_response = %{
      message: "User created",
      user: user,
      token: token
    }

    assert expected_response == response
  end
end
