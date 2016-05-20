defmodule Agendabot.Agenda do
  use Agendabot.Web, :model
  import Ecto.Query

  schema "agendas" do
    field :channel_id, :string
    field :meeting_at, Timex.Ecto.DateTime
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

  def for_channel(qry, channel_id) do
    from a in qry,
    where: a.channel_id == ^channel_id
  end

  def latest_pair(qry) do
    from a in qry,
    order_by: [desc: a.meeting_at],
    limit: 2
  end

  def channel_interval(channel_id) do
    agendas = Agendabot.Agenda |> for_channel(channel_id) |> latest_pair
    if length(agendas) == 2 do
      days_between(List.first(agendas), List.last(agendas))
    else
      nil
    end
  end

  def days_between(a, b) do
    nil
  end
end
