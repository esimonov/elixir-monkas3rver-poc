defmodule WelcomeController do
  @spec index() :: binary()
  def index() do
    %{message: "Welcome!"}
    |> Jason.encode!()
  end
end
