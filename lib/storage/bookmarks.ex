defmodule POCService.Storage do
  @doc """
  Get list of enities.
  """
  @callback get_many(resource :: atom()) :: {:ok, list()} | {:error, any()}
end

defmodule POCService.Storage.MongoDB do
  @behaviour POCService.Storage

  @doc """
  Returns the list of bookmarks.
  """
  @spec get_many(:bookmarks) :: {:ok, list()} | {:error, any()}
  def get_many(:bookmarks) do
    if :rand.uniform() <= 0.5 do
      {:ok, []}
    else
      {:error, "Unlucky coin toss!"}
    end
  end
end
