defmodule Infinityloop.ItemControllerTest do
  use Infinityloop.ConnCase

  alias Infinityloop.Item
  @valid_attrs %{content: "some content", id_analyze: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, item_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing items"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, item_path(conn, :new)
    assert html_response(conn, 200) =~ "New item"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, item_path(conn, :create), item: @valid_attrs
    assert redirected_to(conn) == item_path(conn, :index)
    assert Repo.get_by(Item, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, item_path(conn, :create), item: @invalid_attrs
    assert html_response(conn, 200) =~ "New item"
  end

  test "shows chosen resource", %{conn: conn} do
    item = Repo.insert %Item{}
    conn = get conn, item_path(conn, :show, item)
    assert html_response(conn, 200) =~ "Show item"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    item = Repo.insert %Item{}
    conn = get conn, item_path(conn, :edit, item)
    assert html_response(conn, 200) =~ "Edit item"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    item = Repo.insert %Item{}
    conn = put conn, item_path(conn, :update, item), item: @valid_attrs
    assert redirected_to(conn) == item_path(conn, :index)
    assert Repo.get_by(Item, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    item = Repo.insert %Item{}
    conn = put conn, item_path(conn, :update, item), item: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit item"
  end

  test "deletes chosen resource", %{conn: conn} do
    item = Repo.insert %Item{}
    conn = delete conn, item_path(conn, :delete, item)
    assert redirected_to(conn) == item_path(conn, :index)
    refute Repo.get(Item, item.id)
  end
end
