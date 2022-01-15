defmodule ExAws.EventBridgeTest do
  use ExUnit.Case, async: true
  alias ExAws.EventBridge

  # These tests are intended to validate the requests are being formed as expected.

  test "list_event_buses/1 with no opts" do
    expected_data = %{}

    assert EventBridge.list_event_buses().data == expected_data
  end

  test "list_event_buses/1 with name prefix" do
    expected_data = %{"NamePrefix" => "my_prefix"}

    assert EventBridge.list_event_buses(name_prefix: "my_prefix").data == expected_data
  end
end
