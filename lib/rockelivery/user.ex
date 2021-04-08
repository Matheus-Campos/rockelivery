defmodule Rockelivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rockelivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}

  @permitted_params [:address, :age, :cep, :cpf, :email, :password, :name, :city, :uf]
  @required_params @permitted_params -- [:city, :uf]
  @update_params @required_params -- [:password]

  @derive {Jason.Encoder, only: [:id, :age, :cpf, :address, :email, :name, :city, :uf]}

  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :city, :string
    field :uf, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    has_many :orders, Order

    timestamps()
  end

  def build(params) do
    %__MODULE__{}
    |> changeset(params)
    |> apply_action(:create)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @permitted_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_struct()
    |> put_password_hash()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @permitted_params)
    |> validate_struct()
  end

  defp validate_struct(struct) do
    struct
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
