defmodule Agendabot.AnnounceAgendaCommand do
  defstruct([])

  import Slack.SlashcmdResponse
  import Ecto.Query

  defimpl Agendabot.Command, for: Agendabot.AnnounceAgendaCommand do
    def apply(cmd, ctx) do
      qry = from a in Agendabot.Agenda,
            where: a.channel_id == ^ctx.channel_id,
            order_by: [desc: a.meeting_at]
      agenda = Agendabot.Repo.one(qry)

      if is_nil(agenda) do
        ephemeral_response
          |> with_text("Sorry, I don't know of an agenda for #{ctx.channel_id}")
      else
        in_channel_response
          |> with_text("The agenda for #{ctx.channel_id}")
          |> with_attachment(%{
              "title" => "Agenda for ##{ctx.channel_id}",
              "title_link" => agenda.post_id
            })
      end
    end

    def is_command(cmd) do
      true
    end
  end
end
