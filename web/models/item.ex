defmodule Infinityloop.Item do
  use Infinityloop.Web, :model

  schema "items" do
    field :id_analyze,  :string
    field :content,  :string

    timestamps
  end

  @required_fields ~w(id_analyze content)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
