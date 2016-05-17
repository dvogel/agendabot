defprotocol Agendabot.Command do
  def apply(cmd, channel_id)
  def is_command(cmd)  
end
