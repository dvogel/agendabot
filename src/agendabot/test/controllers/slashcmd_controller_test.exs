defmodule Agendabot.SlashcmdControllerTest do
  use Agendabot.ConnCase

  # These values are taken from the Slash developer documentation example.
  @dummy_params %{
    :token => "gIkuvaNzQIHg97ATvDxqgjtO",
    :team_id => "T0001",
    :team_domain => "example",
    :channel_id => "C2147483705",
    :channel_name => "test",
    :user_id => "U2147483697",
    :command => "/weather",
    :text => "94070",
    :response_url => "https://hooks.slack.com/commands/1234/5678",
  }

  test "default command without existing agenda", %{conn: conn} do
    params = @dummy_params
              |> Map.put(:command, "/agenda")
              |> Map.put(:text, "")
    conn = conn
            |> post("/slack/slashcmd", params)
    assert conn.state == :sent
    assert conn.status == 200
    assert json_response(conn, 200)
    assert conn.resp_body =~ ~r/Perhaps you meant/
  end

  test "announce command without existing agenda", %{conn: conn} do
    params = @dummy_params
              |> Map.put(:command, "/agenda")
              |> Map.put(:text, "announce")
    conn = conn
            |> post("/slack/slashcmd", params)

    assert conn.state == :sent
    assert conn.status == 200
    assert json_response(conn, 200)
    assert conn.resp_body =~ ~r/Sorry, I don't know of an agenda for/
  end

  test "announce commadn with existing agenda", %{conn: conn} do
    Agendabot.Repo.insert!(%Agendabot.Agenda{
      :channel_id => Map.get(@dummy_params, :channel_id),
      :post_id => "F123456",
      :creator_id => Map.get(@dummy_params, :user_id),
      :meeting_at => Timex.DateTime.now,
    })
    params = @dummy_params
              |> Map.put(:command, "/agenda")
              |> Map.put(:text, "announce")
    conn = conn
            |> post("/slack/slashcmd", params)

    assert conn.state == :sent
    assert conn.status == 200
    assert json_response(conn, 200)
    assert conn.resp_body =~ ~r/Agenda for /
  end
end
