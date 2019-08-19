defmodule Escpos.Image do
  alias Escpos.Commands.Gsv0Format

  def pixels_to_bitmap(w, h, pixels) do
    [
      Gsv0Format.gsv0_normal(),
      <<w::integer-little-32>>,
      <<h::integer-little-32>>,
      make_bitmap(pixels)
    ]
    |> IO.iodata_to_binary()
  end

  defp make_bitmap(pixels) do
    make_bitmap(pixels, <<>>)
  end

  defp make_bitmap([], acc) do
    pad_length = 8 - rem(bit_size(acc), 8)

    if pad_length < 8 do
      <<acc::bitstring, 0::size(pad_length)>>
    else
      acc
    end
  end

  defp make_bitmap([r, g, b, a | rest], acc) do
    white =
      if r > 200 or g > 200 or b > 200 do
        1
      else
        0
      end

    make_bitmap(rest, <<white::size(1), acc::bitstring>>)
  end
end
