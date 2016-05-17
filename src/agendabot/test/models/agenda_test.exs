defmodule Agendabot.AgendaTest do
  use Agendabot.ModelCase

  alias Agendabot.Agenda

  @valid_attrs %{channel_id: "some content", created_at: "2010-04-17 14:00:00", creator_id: "some content", meeting_at: "2010-04-17 14:00:00", post_id: "some content", updated_at: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Agenda.changeset(%Agenda{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Agenda.changeset(%Agenda{}, @invalid_attrs)
    refute changeset.valid?
  end
end
