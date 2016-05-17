defmodule Agendabot.CommandParserTest do
  use ExUnit.Case, async: true

  alias Agendabot.Command

  test "default command" do
    parsed = Agendabot.CommandParser.parse("")
    if !Command.is_command(parsed) do
      flunk("Expected an Agendabot.Command")
    end
  end
end
