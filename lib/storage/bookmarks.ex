defmodule POCService.Storage do
  alias POCService.Model.Bookmark

  @doc """
  Get list of enities.
  """
  @callback get_many(resource :: atom()) :: {:ok, list(Bookmark)} | {:error, any()}
end

defmodule POCService.Storage.MongoDB do
  alias POCService.Model.Bookmark
  @behaviour POCService.Storage

  @doc """
  Returns the list of bookmarks.
  """
  @spec get_many(atom()) :: {:ok, list(Bookmark)} | {:error, any()}
  def get_many(:bookmarks) do
    if :rand.uniform() <= 0.5 do
      {:ok,
       [
         %Bookmark{
           name: "Elixir on Exercism",
           url: "https://exercism.org/tracks/elixir",
           date_added: DateTime.utc_now(),
           tags: ["elixir"]
         }
       ]}
    else
      {:error, "Unlucky coin toss!"}
    end
  end
end

defmodule POCService.Storage.S3 do
  alias POCService.Model.ActivityRecord
  @behaviour POCService.Storage

  @doc """
  Returns the list of activity records.
  """
  @spec get_many(atom()) :: {:ok, list(ActivityRecord)} | {:error, any()}
  def get_many(:activity_records) do
    if :rand.uniform() <= 0.5 do
      {:ok,
       [
         %ActivityRecord{
           ts: DateTime.utc_now()
         }
       ]}
    else
      {:error, "Unlucky coin toss!"}
    end
  end
end
