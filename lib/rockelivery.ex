defmodule Rockelivery do
  alias Rockelivery.Items.Create, as: ItemCreate

  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Delete, as: UserDelete
  alias Rockelivery.Users.Get, as: UserGet
  alias Rockelivery.Users.List, as: UserList
  alias Rockelivery.Users.Update, as: UserUpdate

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate update_user(id), to: UserUpdate, as: :call
  defdelegate get_users(), to: UserList, as: :call

  defdelegate create_item(params), to: ItemCreate, as: :call
end
