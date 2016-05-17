defmodule Agendabot.NewAgendaCommand do
  defstruct([])

  defimpl Agendabot.Command, for: NewAgendaCommand do
    false
  end
end

