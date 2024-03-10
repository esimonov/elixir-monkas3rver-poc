defmodule POCService.Router do
  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  get "/" do
    with body <- WelcomeController.index() do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, body)
    end
  end

  match _ do
    send_resp(conn, 404, "Route not found")
  end
end
