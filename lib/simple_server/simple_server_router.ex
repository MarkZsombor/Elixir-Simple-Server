defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)

  plug(:match)
  plug(:dispatch)

  # Needs some routes
  get "/hello" do
    send_resp(conn, 200, "world")
  end

  post "/post" do
    {:ok, body, conn} = read_body(conn)
    # This decodes the JSON in the req.body
    body = Poison.decode!(body)
    # Pring the body to know what it looks like
    IO.inspect(body)
    send_resp(conn, 201, "created: #{get_in(body, ["message"])}")
  end

  match _ do
    send_resp(conn, 404, "Thats a hard no for me dawg")
  end
end
