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

alias ChoalaApi.Repo


alias ChoalaApi.Accounts.User
alias ChoalaApi.Accounts
user_1 = %User{email: "john@appleseed.com", password: "password", name: "John Appleseed"}
user_2 = %User{email: "kyle@henderson.com", password: "secret", name: "Kyle Henderson"}
Accounts.create_user(user_1)
Accounts.create_user(user_2)

alias ChoalaApi.Accounts.Session
%Session{auth_token: "1", user_id: user_1.id} |> Repo.insert!
%Session{auth_token: "2", user_id: user_2.id} |> Repo.insert!

alias ChoalaApi.Schedule.Event
%Event{name: "morning run", period: 0, mutable: false, user_id: user_1.id} |> Repo.insert!
%Event{name: "breakfast", period: 0, mutable: true, user_id: user_2.id} |> Repo.insert!
