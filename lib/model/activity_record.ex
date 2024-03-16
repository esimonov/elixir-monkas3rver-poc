defmodule POCService.Model.ActivityRecord do
  defstruct [:endpoint, :method, :resp_code, :ts]

  defimpl Jason.Encoder do
    @impl Jason.Encoder
    def encode(value, opts) do
      value
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
