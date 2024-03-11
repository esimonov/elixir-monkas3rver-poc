defmodule HealthController do
  import Plug.Conn, only: [put_resp_content_type: 2, send_resp: 3]

  def health(conn, "live") do
    resp_body =
      %{ok: true}
      |> Jason.encode!()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:ok, resp_body)
  end

  def health(conn, "ready"), do: health(conn, "live")
end
