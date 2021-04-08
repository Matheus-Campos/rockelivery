defmodule Rockelivery.ViaCep.Response do
  @keys [:city, :uf]
  @enforce_keys @keys

  defstruct @keys

  def build(%{"localidade" => city, "uf" => uf}) do
    %__MODULE__{
      city: city,
      uf: uf
    }
  end
end
