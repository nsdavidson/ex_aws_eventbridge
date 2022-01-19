defmodule ExAws.EventBridge do
  @moduledoc """
  Operations on AWS EventBridge service.

  ## Notes
  Based on API spec at https://github.com/aws/aws-sdk-go/blob/main/models/apis/eventbridge/2015-10-07/api-2.json

  Options for requests are passed as a keyword list of underscored atoms, with names matching the API spec above.

  Example: The ListEventBuses request accepts an optional "NamePrefix". Example of this request in this library:
  ```elixir
  ExAws.EventBridge.list_event_buses(name_prefix: "my_prefix")
  ```
  """

  alias ExAws.Operation.JSON

  @target_prefix "AWSEvents"

  @doc """
  List event buses

  ## Example
  ```
  EventBridge.list_event_buses() |> ExAws.request()
  EventBridge.list_event_buses(name_prefix: "my_prefix") |> ExAws.request()
  ```
  """
  @spec list_event_buses(opts :: Keyword.t()) :: JSON.t()
  def list_event_buses(opts \\ []) do
    request(:list_event_buses, opts_to_data(opts))
  end

  @doc """
  Create an event bus

  ## Example
  ```
  EventBridge.create_event_bus("new-bus") |> ExAws.request()
  ```
  """
  @spec create_event_bus(name :: binary, opts :: Keyword.t()) :: JSON.t()
  def create_event_bus(name, opts \\ []) do
    data =
      %{"Name" => name}
      |> Map.merge(opts_to_data(opts))

    request(:create_event_bus, data)
  end

  @doc """
  Delete an event bus

  ## Example
  ```
  EventBridge.delete_event_bus("old-bus") |> ExAws.request()
  ```
  """
  @spec delete_event_bus(name :: binary, opts :: Keyword.t()) :: JSON.t()
  def delete_event_bus(name, opts \\ []) do
    data =
      %{"Name" => name}
      |> Map.merge(opts_to_data(opts))

    request(:delete_event_bus, data)
  end

  @doc """
  Describe an event bus

  ## Example
  ```
  EventBridge.describe_event_bus("my-bus") |> ExAws.request()
  ```
  """
  @spec describe_event_bus(name :: binary, opts :: Keyword.t()) :: JSON.t()
  def describe_event_bus(name, opts \\ []) do
    data =
      %{"Name" => name}
      |> Map.merge(opts_to_data(opts))

    request(:describe_event_bus, data)
  end

  @spec put_events(event_list :: List.t(), opts :: Keyword.t()) :: JSON.t()
  def put_events(event_list, opts \\ []) do
    data =
      %{"Entries" => Enum.map(event_list, fn event -> opts_to_data(event) end)}
      |> Map.merge(opts_to_data(opts))

    request(:put_events, data)
  end

  defp opts_to_data(_opts = []), do: %{}

  defp opts_to_data(opts) do
    opts
    |> Enum.into(%{}, fn {k, v} -> {atom_to_string(k), v} end)
  end

  defp request(operation, data, opts \\ %{}) do
    JSON.new(
      :events,
      %{
        data: data,
        headers: headers(operation)
      }
      |> Map.merge(opts)
    )
  end

  defp headers(operation) do
    [
      {"x-amz-target", "#{@target_prefix}.#{atom_to_string(operation)}"},
      {"content-type", "application/x-amz-json-1.1"}
    ]
  end

  defp atom_to_string(string) do
    string
    |> Atom.to_string()
    |> Macro.camelize()
  end
end
