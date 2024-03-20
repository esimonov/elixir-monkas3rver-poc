defmodule BookmarksController do
  alias POCService.Model.ActivityRecord
  require Logger

  import Plug.Conn, only: [put_resp_content_type: 2, send_resp: 3]

  @producer Application.compile_env(:poc_service, :producer_impl)
  @storage Application.compile_env(:poc_service, :bookmarks_storage_impl)

  def get_many(conn) do
    with {:ok, bookmarks} <- @storage.get_many(:bookmarks),
         {:ok, nil} <- produce_activity_record(conn) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:ok, Jason.encode!(bookmarks))
    else
      {:error, reason} ->
        Logger.error("Fetching bookmarks", reason: reason)

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(:internal_server_error, Jason.encode!(%{error: reason}))
    end
  end

  defp produce_activity_record(conn) do
    @producer.produce("mock.activity-records", false, [
      %ActivityRecord{
        endpoint: conn.path_info,
        method: conn.method,
        resp_code: :ok,
        ts: DateTime.utc_now()
      }
    ])
  end
end
