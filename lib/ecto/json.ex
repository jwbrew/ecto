if Code.ensure_loaded?(Jason.Encoder) do
  defimpl Jason.Encoder, for: Ecto.Schema.Metadata do
    def encode(%{schema: schema}, _) do
      raise """
      cannot encode metadata from the :__meta__ field for #{inspect(schema)} \
      to JSON. This metadata is used internally by Ecto and should never be \
      exposed externally.

      You can either map the schemas to remove the :__meta__ field before \
      encoding to JSON, or explicit list the JSON fields in your schema:

          defmodule #{inspect(schema)} do
            # ...

            @derive {Jason.Encoder, only: [:name, :title, ...]}
            schema ... do
      """
    end
  end
end
