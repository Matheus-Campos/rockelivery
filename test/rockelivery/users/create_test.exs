defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Users.Create
  alias Rockelivery.{Error, User}

  describe "call/1" do
    test "when all params are valid, returns the user" do
      response =
        :user_params
        |> build()
        |> Enum.into(%{}, fn {key, value} -> {Atom.to_string(key), value} end)
        |> Create.call()

      assert {:ok, %User{id: _id, age: 22, email: "silva.campos.matheus@gmail.com"}} = response
    end

    test "when there are invalid params, returns an error" do
      response =
        :user_params
        |> build(%{password: "123", age: 15})
        |> Enum.into(%{}, fn {key, value} -> {Atom.to_string(key), value} end)
        |> Create.call()

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{result: changeset, status: :bad_request}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
