defmodule Agendabot.AddAgendaItemCommand do
  defstruct text: nil

  defimpl Agendabot.Command, for: Agendabot.AddAgendaItemCommand do
    def apply(cmd, channel_id) do
      nil
    end

    def is_command(cmd) do
      true
    end
  end
end

