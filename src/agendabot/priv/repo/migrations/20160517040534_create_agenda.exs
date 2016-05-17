defmodule Agendabot.Repo.Migrations.CreateAgenda do
  use Ecto.Migration

  def change do
    create table(:agendas) do
      add :channel_id, :string
      add :meeting_at, :datetime
      add :post_id, :string
      add :creator_id, :string

      timestamps
    end

  end
end
