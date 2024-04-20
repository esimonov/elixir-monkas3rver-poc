defmodule POCService.Producer do
  @doc """
  Produce messages to a topic.
  """
  @callback produce(resource_type :: atom(), messages :: list()) :: {:ok, nil} | {:error, any()}
end

defmodule POCService.Producer.Kafka do
  alias POCService.Model.ActivityRecord
  require Logger

  @behaviour POCService.Producer

  @doc """
  Returns the list of bookmarks.
  """
  @spec produce(atom(), list()) :: {:ok, nil} | {:error, any()}
  def produce(:activity_records, records) do
    with messages <- Enum.map(records, &add_key/1),
         :ok <- Kaffe.Producer.produce_sync("dev.activity-records", messages) do
      {:ok, nil}
    else
      {:error, reason} ->
        Logger.error("Producing to Kafka", topic_name: "dev.activity-records", reason: reason)
    end
  end

  def produce(_resource_type, _list), do: {:error, "Not Implemented"}

  defp add_key(%ActivityRecord{method: method} = record) do
    {Jason.encode!(method), Jason.encode!(record)}
  end

  defp add_key(_doc), do: {:error, "Not Implemented"}
end
