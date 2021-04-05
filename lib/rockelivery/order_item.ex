defmodule Rockelivery.OrderItem do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rockelivery.{Item, Order}

  @primary_key false
  @foreign_key_type :binary_id

  schema "orders_items" do
    belongs_to :item, Item
    belongs_to :order, Order

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
