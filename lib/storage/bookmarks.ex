defmodule POCService.Storage.MongoDB do
  alias POCService.Model.Bookmark
  alias POCService.Storage.Utils

  @behaviour POCService.Storage

  @bookmarks_coll_name "bookmarks"

  @doc """
  Returns the list of bookmarks.
  """
  @spec get_many(atom()) :: {:ok, list(Bookmark)} | {:error, any()}
  def get_many(:bookmarks) do
    with bookmarks <-
           Mongo.find(:mongo, @bookmarks_coll_name, %{})
           |> Enum.map(&Utils.normaliseMongoId/1)
           |> Enum.to_list() do
      {:ok, bookmarks}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
