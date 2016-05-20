defmodule Agendabot.SlashcmdController do
  use Agendabot.Web, :controller

  alias Agendabot.Command
  alias Agendabot.CommandParser

  import ExConstructor, only: [populate_struct: 2]

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
    cmd_params = populate_struct(%Slack.SlashcmdParams{}, params)
    response = CommandParser.parse(text)
                |> Command.apply(cmd_params)
    json(conn, response)
  end

  def error_response(msg) do
    %{ "text" => msg }
  end
end
