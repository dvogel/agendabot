defmodule Agendabot.SlashcmdController do
  use Agendabot.Web, :controller

  alias Agendabot.Command
  alias Agendabot.CommandParser

  def slashcmd(conn, params) do
    # Slack sends these params:
    # token=gIkuvaNzQIHg97ATvDxqgjtO
    # team_id=T0001
    # team_domain=example
    # channel_id=C2147483705
    # channel_name=test
    # user_id=U2147483697
    # user_name=Steve
    # command=/weather
    # text=94070
    # response_url=https://hooks.slack.com/commands/1234/5678

    %{ "command" => command } = params
    case command do
      "/agenda" -> handle_agenda_cmd(conn, params)
      true -> json(conn, error_response("Agendabot received an unknown command: #{:command}"))
    end
  end

  def handle_agenda_cmd(conn, params) do
    %{ "text" => text } = params
    %{ "channel_id" => channel_id } = params
    response = CommandParser.parse(text)
                |> Command.apply(channel_id)
    json(conn, response)
  end

  def error_response(msg) do
    %{ "text" => msg }
  end
end
