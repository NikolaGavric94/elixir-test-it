defmodule Infinityloop.ItemController do
  use Infinityloop.Web, :controller

  alias Infinityloop.Item

  plug :scrub_params, "item" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    items = Repo.all(Item)
    render(conn, "index.html", items: items)
  end

  def new(conn, _params) do
    changeset = Item.changeset(%Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => item_params}) do
    changeset = Item.changeset(%Item{}, item_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Item created successfully.")
      |> redirect(to: item_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Repo.get(Item, id)
    render(conn, "show.html", item: item)
  end

  def edit(conn, %{"id" => id}) do
    item = Repo.get(Item, id)
    changeset = Item.changeset(item)
    render(conn, "edit.html", item: item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Repo.get(Item, id)
    changeset = Item.changeset(item, item_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Item updated successfully.")
      |> redirect(to: item_path(conn, :index))
    else
      render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Repo.get(Item, id)
    Repo.delete(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: item_path(conn, :index))
  end
end
