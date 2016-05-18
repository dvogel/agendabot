defmodule Agendabot.CommandParserTest do
  use ExUnit.Case, async: true

  alias Agendabot.Command

  def is_agendabot_command (parsed) do
    if !Command.is_command(parsed) do
      flunk("Expected an Agendabot.Command")
    end
  end

  test "default command" do
    is_agendabot_command(Agendabot.CommandParser.parse(""))
  end

  test "help command" do
    is_agendabot_command(Agendabot.CommandParser.parse("help"))
  end

  test "new agenda command" do
    is_agendabot_command(Agendabot.CommandParser.parse("new"))
  end

  test "add new item command" do
    is_agendabot_command(Agendabot.CommandParser.parse("add discussion of agendabot"))
  end

  test "announce command" do
    is_agendabot_command(Agendabot.CommandParser.parse("announce"))
  end
end
