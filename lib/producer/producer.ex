defmodule POCService.Producer do
  @doc """
  Produce messages to a topic.
  """
  @callback produce(topic_name :: String.t(), async? :: boolean(), messages :: list()) ::
              :ok | {:error, any()}
end

defmodule POCService.Producer.Kafka do
  require Logger

  @behaviour POCService.Producer

  @doc """
  Returns the list of bookmarks.
  """
  @spec produce(String.t(), boolean(), list()) ::
          :ok | {:error, any()}
  def produce(_topic_name, _async?, messages) do
    if :rand.uniform() <= 0.5 do
      Logger.info("Produced messages", messages: messages)
      :ok
    else
      {:error, "Kafka error"}
    end
  end
end
