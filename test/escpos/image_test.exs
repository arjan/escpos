defmodule Escpos.ImageTest do
  use ExUnit.Case

  alias Escpos.Image

  test "pixels_to_bitmap" do
    Image.pixels_to_bitmap(10, 10, [255, 3, 4, 5])
    |> IO.inspect(label: "x")
  end
end
