defmodule Escpos.ImageTest do
  use ExUnit.Case

  alias Escpos.Image

  test "pixels_to_bitmap" do
    {:ok, pixels} = Pixels.read_file("test/dot.png")

    lines =
      Image.pixels_to_bitmap(pixels)
      |> Base.encode16()
      |> String.to_charlist()
      |> Enum.chunk_every(8)

    for l <- lines, do: IO.puts(l)
  end

  test "image padding" do
    assert {"", ""} = Image.padding(32)
    assert {<<0::size(2)>>, <<0::size(3)>>} = Image.padding(4315)
  end
end
