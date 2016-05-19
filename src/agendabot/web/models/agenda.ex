defmodule Agendabot.Agenda do
  use Agendabot.Web, :model
  import Ecto.Query

  schema "agendas" do
    field :channel_id, :string
    field :meeting_at, Ecto.DateTime
    field :post_id, :string
    field :creator_id, :string

    timestamps
  end

  @required_fields ~w(channel_id meeting_at post_id creator_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

end
