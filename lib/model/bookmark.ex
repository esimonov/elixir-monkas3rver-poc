defmodule POCService.Model.Bookmark do
  defstruct [:id, :name, :url, :date_added, :tags]

  defimpl Jason.Encoder do
    @impl Jason.Encoder
    def encode(value, opts) do
      value
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
