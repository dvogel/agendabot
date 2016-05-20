defprotocol Agendabot.Command do
  def apply(cmd, ctx)
  def is_command(cmd)  
end
