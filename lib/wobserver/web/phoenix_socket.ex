defmodule Wobserver.Web.PhoenixSocket do
  @moduledoc """
  Drop-in Phoenix Socket for easier integration in to Phoenix endpoints

  Example:
    ```elixir
    defmodule MyPhoenixServer.Endpoint do
      socket "/wobserver", Wobserver.Web.PhoenixSocket # The path should be the same as the router path

      ...
    end
    ```
  """

  def child_spec(opts) do
    Phoenix.Socket.__child_spec__(__MODULE__, opts)
  end

  @doc false
  def __transports__ do
    config = [
      cowboy: Wobserver.Web.Client
    ]
    callback_module = __MODULE__
    transport_path = :websocket
    websocket_socket = {transport_path, {callback_module, config}}
    # Only handling one type, websocket, no longpolling or anything else
    [
      websocket_socket
    ]
  end
end
