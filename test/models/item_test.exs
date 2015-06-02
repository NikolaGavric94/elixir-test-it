defmodule Infinityloop.ItemTest do
  use Infinityloop.ModelCase

  alias Infinityloop.Item

  @valid_attrs %{content: "some content", id_analyze: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Item.changeset(%Item{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Item.changeset(%Item{}, @invalid_attrs)
    refute changeset.valid?
  end
end
