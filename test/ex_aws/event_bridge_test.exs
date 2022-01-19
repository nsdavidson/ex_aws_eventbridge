defmodule ExAws.EventBridgeTest do
  use ExUnit.Case, async: true
  alias ExAws.EventBridge

  # These tests are intended to validate the requests are being formed as expected.

  test "list_event_buses/1 with no opts" do
    expected_data = %{}
    request = EventBridge.list_event_buses()

    assert request.data == expected_data
    assert request.headers == expected_headers("ListEventBuses")
  end

  test "list_event_buses/1 with name prefix" do
    expected_data = %{"NamePrefix" => "my_prefix"}
    request = EventBridge.list_event_buses(name_prefix: "my_prefix")

    assert request.data == expected_data
    assert request.headers == expected_headers("ListEventBuses")
  end

  test "create_event_bus/2" do
    expected_data = %{"Name" => "test-bus"}
    request = EventBridge.create_event_bus("test-bus")

    assert request.data == expected_data
    assert request.headers == expected_headers("CreateEventBus")
  end

  test "delete_event_bus/2" do
    expected_data = %{"Name" => "test-bus"}
    request = EventBridge.delete_event_bus("test-bus")

    assert request.data == expected_data
    assert request.headers == expected_headers("DeleteEventBus")
  end

  test "describe_event_bus/2" do
    expected_data = %{"Name" => "test-bus"}
    request = EventBridge.describe_event_bus("test-bus")
    assert request.data == expected_data
    assert request.headers == expected_headers("DescribeEventBus")
  end

  test "put_events/2" do
    events = [
      %{
        detail: "{\"key\":\"value\"}",
        detail_type: "thing1",
        event_bus_name: "default",
        source: "the_place"
      },
      %{
        detail: "{\"key2\":\"value2\"}",
        detail_type: "thing2",
        event_bus_name: "default",
        source: "the_good_place"
      }
    ]

    expected_data = %{
      "Entries" => [
        %{
          "Detail" => "{\"key\":\"value\"}",
          "DetailType" => "thing1",
          "EventBusName" => "default",
          "Source" => "the_place"
        },
        %{
          "Detail" => "{\"key2\":\"value2\"}",
          "DetailType" => "thing2",
          "EventBusName" => "default",
          "Source" => "the_good_place"
        }
      ]
    }

    request = EventBridge.put_events(events)
    assert request.data == expected_data
    assert request.headers == expected_headers("PutEvents")
  end

  defp expected_headers(operation) do
    [
      {"x-amz-target", "AWSEvents.#{operation}"},
      {"content-type", "application/x-amz-json-1.1"}
    ]
  end
end
