defmodule POCService.Storage.Utils do
  @moduledoc """
  Utility functions.
  """

  def normaliseMongoId(doc) do
    doc
    |> Map.put(~c"id", BSON.ObjectId.encode!(doc["_id"]))
    |> Map.delete("_id")
  end
end
