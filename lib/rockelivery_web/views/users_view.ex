defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view

  alias Rockelivery.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created",
      user: user
    }
  end

  def render("index.json", %{users: users}) do
    %{users: users}
  end

  def render("user.json", %{user: %User{} = user}), do: %{user: user}
end
