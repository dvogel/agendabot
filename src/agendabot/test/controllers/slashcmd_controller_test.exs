defmodule Agendabot.SlashcmdControllerTest do
  use Agendabot.ConnCase

  @dummy_params %{
    :token => 'gIkuvaNzQIHg97ATvDxqgjtO',
    :team_id => 'T0001',
    :team_domain => 'example',
    :channel_id => 'C2147483705',
    :channel_name => 'test',
    :user_id => 'U2147483697',
    :command => '/weather',
    :text => '94070',
    :response_url => 'https://hooks.slack.com/commands/1234/5678',
  }

  test "default command without existing agenda", %{conn: conn} do
    params = @dummy_params
              |> Map.put(:command, '/agenda')
              |> Map.put(:text, "")
    conn = conn
            |> post("/slack/slashcmd", params)
    assert conn.state == :sent
    assert conn.status == 200
    assert json_response(conn, 200)
    assert conn.resp_body =~ ~r/Perhaps you meant/
  end
end
