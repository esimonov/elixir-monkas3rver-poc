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

  def insert_one(:activity_records, _any) do
    {:error, "Not implemented"}
  end
end
