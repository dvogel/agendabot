defmodule Slack.SlashcmdParams do
  defstruct(
    team_id: nil,
    team_domain: nil,
    channel_id: nil,
    channel_name: nil,
    user_id: nil,
    user_name: nil,
    response_url: nil
  )
end

