defmodule BookmarksController do
  import Plug.Conn, only: [put_resp_content_type: 2, send_resp: 3]

  @storage Application.compile_env(:poc_service, :storage_impl)

  def get_many(conn) do
    case @storage.get_many(:bookmarks) do
      {:ok, bookmarks} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(:ok, Jason.encode!(bookmarks))

      {:error, reason} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(:internal_server_error, Jason.encode!(%{error: reason}))
    end
  end
end
