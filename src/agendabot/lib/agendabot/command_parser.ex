defmodule Agendabot.CommandParser do
  alias Agendabot.AddAgendaItemCommand
  alias Agendabot.AnnounceAgendaCommand
  alias Agendabot.DefaultCommand
  alias Agendabot.HelpCommand
  alias Agendabot.NewAgendaCommand

  def drop_whitespace (tokens) do
    Enum.drop_while(tokens, fn(t) -> String.match?(t, ~r/\s+/) end)
  end

  def parse (text) do
    tokens = Regex.split(~r/(\s+)/, text, trim: true)
              |> drop_whitespace
    if length(tokens) == 0 do
      %DefaultCommand{}
    else
      [ subcmd | tokens ] = tokens
      case subcmd do
        'add' -> parse_add_arguments(tokens)
        'new' -> %NewAgendaCommand{}
        'announce' -> %AnnounceAgendaCommand{}
        'help' -> %HelpCommand{}
      end
    end
  end


  def parse_add_arguments (tokens) do
    # TODO: Parse the tokens
    %AddAgendaItemCommand{text: 'TODO'}
  end
end
