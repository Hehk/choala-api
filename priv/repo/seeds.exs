# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ChoalaApi.Repo.insert!(%ChoalaApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ChoalaApi.Schedule.Event
alias ChoalaApi.Repo

%Event{name: "morning run", period: 0, mutable: false} |> Repo.insert!
%Event{name: "breakfast", period: 0, mutable: true} |> Repo.insert!
