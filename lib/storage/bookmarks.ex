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

  @spec insert_one(atom(), any()) :: {:ok, any()} | {:error, any()}
  def insert_one(:bookmarks, bookmark) do
    with {:ok, %Mongo.InsertOneResult{inserted_id: inserted_id}} <-
           Mongo.insert_one(:mongo, @bookmarks_coll_name, bookmark),
         inserted <-
           Mongo.find_one(:mongo, @bookmarks_coll_name, %{_id: inserted_id})
           |> Utils.normaliseMongoId() do
      {:ok, inserted}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
