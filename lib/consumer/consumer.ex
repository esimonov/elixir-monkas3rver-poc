defmodule POCService.ActivityRecordsConsumer do
  @spec handle_message(%{:key => any(), :value => any(), optional(any()) => any()}) :: :ok
  def handle_message(%{key: key, value: value} = message) do
    IO.inspect(message)
    IO.puts("#{key}: #{value}")
    :ok
  end
end
