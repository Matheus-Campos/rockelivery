defmodule Rockelivery.Users.Create do
  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rockelivery.{Error, Repo, User}
  alias Rockelivery.ViaCep.Response, as: ViaCepResponse

  def call(params) do
    cep = Map.get(params, "cep")

    with %Changeset{valid?: true} = changeset <- User.changeset(params),
         {:ok, %User{}} <- apply_action(changeset, :create),
         {:ok, %ViaCepResponse{city: city, uf: uf}} <- via_cep_client().get_cep_info(cep),
         %Changeset{valid?: true} = changeset <- change(changeset, city: city, uf: uf),
         {:ok, %User{}} = result <- Repo.insert(changeset) do
      result
    else
      %Changeset{valid?: false} = changeset -> {:error, Error.build(:bad_request, changeset)}
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  defp via_cep_client do
    :rockelivery
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_cep_adapter)
  end
end
