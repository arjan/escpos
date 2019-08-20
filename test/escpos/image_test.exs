defmodule Escpos.ImageTest do
  use ExUnit.Case

  alias Escpos.Image

  test "pixels_to_bitmap" do
    {:ok, {w, h, pixels}} = Imago.read_pixels("test/dot.png")

    Image.pixels_to_bitmap(w, h, pixels)
    |> Base.encode16()
    |> String.to_charlist()
    |> Enum.chunk_every(8)
    |> IO.inspect(label: "x")
  end

  test "image padding" do
    assert {"", ""} = Image.padding(32)
    assert {<<0::size(2)>>, <<0::size(3)>>} = Image.padding(4315)
  end
end
