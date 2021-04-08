defmodule Rockelivery.Users.Create do
  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rockelivery.{Error, Repo, User}
  alias Rockelivery.ViaCep.Client
  alias Rockelivery.ViaCep.Response, as: ViaCepResponse

  def call(%{"cep" => cep} = params) do
    changeset = User.changeset(params)

    with {:ok, %User{}} <- apply_action(changeset, :create),
         {:ok, %ViaCepResponse{city: city, uf: uf}} <- Client.get_cep_info(cep),
         %Changeset{valid?: true} = changeset <- change(changeset, city: city, uf: uf),
         {:ok, %User{}} = result <- Repo.insert(changeset) do
      result
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end
end
