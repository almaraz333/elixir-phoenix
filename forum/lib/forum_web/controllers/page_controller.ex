defmodule ForumWeb.PageController do
  use ForumWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def users(conn, _params) do
    IO.puts("Users function hit")
    users = [
      %{id: 1, name: "alice", email: "alice@email.com"},
      %{id: 2, name: "bob", email: "bob@email.com"},
      %{id: 3, name: "storm", email: "storm@email.com"},
      %{id: 4, name: "ranger", email: "ranger@email.com"},
    ]

    json(conn, %{users: users})
  end
end
