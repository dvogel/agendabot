defmodule Agendabot.HelpCommand do
  defstruct([])

  defimpl Agendabot.Command, for: Agendabot.HelpCommand do
    def apply(cmd, channel_id) do
      nil
    end

    def is_command(cmd) do
      true
    end
  end
end
