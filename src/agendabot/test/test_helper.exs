ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Agendabot.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Agendabot.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Agendabot.Repo)

