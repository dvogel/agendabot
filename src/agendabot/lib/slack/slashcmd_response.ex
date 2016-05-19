defmodule Slack.SlashcmdResponse do

  def in_channel_response (r \\ nil) do
    r1 = case r do
      nil -> %{}
      true -> r
    end

    Map.put(r1, "response_type", "in_channel")
  end

  def ephemeral_response (r \\ nil) do
    r1 = case r do
      nil -> %{}
      true -> r
    end

    Map.delete(r1, "response_type")
  end

  def with_text(r, txt) do
    Map.put(r, "text", txt)
  end

  def with_attachment(r, attrs) do
    Map.update(r, "attachments", [attrs], fn cur_val ->
      List.insert_at(cur_val, -1, attrs)
    end)
  end
end

