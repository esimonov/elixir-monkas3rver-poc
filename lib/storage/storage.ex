defmodule POCService.Storage do
  @doc """
  Get list of enities.
  """

  @callback get_many(resource :: atom()) :: {:ok, list} | {:error, any()}
  @callback insert_one(resource :: atom(), any) :: {:ok, any()} | {:error, any()}
end
