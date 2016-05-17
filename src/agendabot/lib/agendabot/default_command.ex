defmodule Agendabot.DefaultCommand do
  defstruct([])

  defimpl Agendabot.Command, for: Agendabot.DefaultCommand do
    def apply(cmd, channel_id) do
      %{ "text" => "No agenda exists for #{channel_id}",
         "attachments" => [
           %{ "text" => "Perhaps you meant /agenda help" }
         ]
       }
    end

    def is_command(cmd) do
      true
    end
  end

end
