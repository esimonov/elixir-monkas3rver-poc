defmodule POCService.Router do
  use Plug.ErrorHandler
  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  get("/activity-records", do: ActivityRecordsController.get_many(conn))

  get("/bookmarks", do: BookmarksController.get_many(conn))

  get("/health/:path" when path in ~w(live ready), do: HealthController.health(conn, path))

  match _ do
    resp_body =
      %{error: "Route not found"}
      |> Jason.encode!()

    send_resp(conn, :not_found, resp_body)
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    resp_body =
      %{error: "Something went wrong"}
      |> Jason.encode!()

    send_resp(conn, conn.status, resp_body)
  end
end
