defmodule Agendabot.NewAgendaCommand do
  defstruct([])
end

defimpl Agendabot.Command, for: Agendabot.NewAgendaCommand do
  def apply(cmd, ctx) do
    agendas = Agendabot.Agenda
              |> Agendabot.for_channel(ctx.channel_id)
              |> Agendabot.latest_pair
              |> Agendabot.Repo.all

    case length(agendas) do
      0 -> apply_first_agenda(cmd, ctx)
      1 -> apply_second_agenda(cmd, ctx, List.first(agendas))
      true -> apply_interval(cmd, ctx, agendas)
    end

    false
  end

  def apply_first_agenda(cmd, ctx) do
    post_id = 'JUNK'
    meeting_at = nil
    Agendabot.Repo.insert!(%Agendabot.Agenda{
      :channel_id => ctx.channel_id,
      :post_id => post_id,
      :creator_id => ctx.user_id,
      :meeting_at => meeting_at,
    })
  end

  def apply_second_agenda(cmd, ctx, prev_agenda) do
  end

  def apply_interval(cmd, ctx, prev_agendas) do
    later_dt = List.first(prev_agendas).meeting_at
    earlier_dt = List.last(prev_agendas).meeting_at

    days_between = Timex.diff(later_dt, earlier_dt, :days)
    offset_into_day = Timex.diff(later_dt, Timex.beginning_of_day(later_dt), :timestamp)

    new_date = Timex.add(Timex.beginning_of_day(later_dt).to_julian, days_between)
    new_dt = Timex.add(new_date, offset_into_day)

    post_id = 'JUNK'
    Agendabot.Repo.insert!(%Agendabot.Agenda{
      :channel_id => ctx.channel_id,
      :post_id => post_id,
      :creator_id => ctx.user_id,
      :meeting_at => new_dt,
    })
  end

  def is_command(cmd) do
    true
  end
end
