defmodule Agendabot.NewAgendaCommand do
  defstruct([])
end

defimpl Agendabot.Command, for: Agendabot.NewAgendaCommand do
  def apply(cmd, channel_id) do
    false
  end

  def is_command(cmd) do
    true
  end
end
