defmodule BookmarksController do
  alias POCService.Model.ActivityRecord
  require Logger

  import Plug.Conn, only: [put_resp_content_type: 2, send_resp: 3]

  @producer Application.compile_env(:poc_service, :activity_records_producer_impl)
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

      _ ->
        Logger.error("Fetching bookmarks", reason: :unknown)
    end
  end

  def insert_one(conn) do
    case conn.body_params do
      %{"name" => _name, "url" => _url} = bookmark ->
        with {:ok, inserted} <- @storage.insert_one(:bookmarks, bookmark),
             {:ok, nil} <- produce_activity_record(conn) do
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(:ok, Jason.encode!(inserted))
        else
          {:error, reason} ->
            Logger.error("Inserting bookmark", reason: reason)

            conn
            |> put_resp_content_type("application/json")
            |> send_resp(:internal_server_error, Jason.encode!(%{error: reason}))
        end

      _ ->
        send_resp(conn, 400, "Invalid body")
    end
  end

  defp produce_activity_record(conn) do
    @producer.produce(:activity_records, [
      %ActivityRecord{
        endpoint: conn.path_info,
        method: conn.method,
        resp_code: :ok,
        ts: DateTime.utc_now()
      }
    ])
  end
end
