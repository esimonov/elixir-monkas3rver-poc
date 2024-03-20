defmodule ActivityRecordsController do
  require Logger

  import Plug.Conn, only: [put_resp_content_type: 2, send_resp: 3]

  @storage Application.compile_env(:poc_service, :activity_records_storage_impl)

  def get_many(conn) do
    case @storage.get_many(:activity_records) do
      {:ok, records} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(:ok, Jason.encode!(records))

      {:error, reason} ->
        Logger.error("Fetching activity records", reason: reason)

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(:internal_server_error, Jason.encode!(%{error: reason}))
    end
  end
end
