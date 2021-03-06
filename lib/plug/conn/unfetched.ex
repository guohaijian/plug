defmodule Plug.Conn.Unfetched do
  @moduledoc """
  A struct used as default on unfetched fields.

  The `:aspect` key of the struct specifies what field is still unfetched.

  ## Examples

      unfetched = %Plug.Conn.Unfetched{aspect: :cookies}

  """

  defstruct [:aspect]
  @type t :: %__MODULE__{aspect: atom()}

  @behaviour Access

  def fetch(%{aspect: aspect}, key) do
    raise_unfetched(__ENV__.function, aspect, key)
  end

  def get(%{aspect: aspect}, key, _value) do
    raise_unfetched(__ENV__.function, aspect, key)
  end

  def get_and_update(%{aspect: aspect}, key, _fun) do
    raise_unfetched(__ENV__.function, aspect, key)
  end

  def pop(%{aspect: aspect}, key) do
    raise_unfetched(__ENV__.function, aspect, key)
  end

  defp raise_unfetched({access, _}, aspect, key) do
    raise ArgumentError,
          "cannot #{access} key #{inspect(key)} from conn.#{aspect} because they were not fetched"
  end
end
