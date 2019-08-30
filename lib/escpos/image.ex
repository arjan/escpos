defmodule Escpos.Image do
  alias Escpos.Commands.Gsv0Format

  @chunk_height 128

  def pixels_to_bitmap(pixels) do
    pixels_to_iodata(pixels) |> IO.iodata_to_binary()
  end

  def pixels_to_iodata(%Pixels{width: w, height: h, data: data}) when h <= @chunk_height do
    data = make_bitmap(data, w, <<>>)

    iw = trunc(bit_size(data) / h / 8)
    ih = h

    [
      Gsv0Format.gsv0_normal(),
      <<iw::size(8), 0::size(8)>>,
      <<ih::size(8), 0::size(8)>>,
      data
    ]
  end

  def pixels_to_iodata(%Pixels{width: w, height: h, data: data}) do
    n = w * 4 * @chunk_height
    <<data::binary-size(n), rest::binary>> = data

    [
      pixels_to_bitmap(%Pixels{width: w, height: @chunk_height, data: data}),
      pixels_to_bitmap(%Pixels{width: w, height: h - @chunk_height, data: rest})
    ]
  end

  defp make_bitmap(<<>>, _, acc) do
    acc
  end

  defp make_bitmap(data, width, acc) do
    {row, rest} = make_bitmap_row(data, width, <<>>)
    {bl, br} = padding(width)
    make_bitmap(rest, width, <<acc::bitstring, bl::bitstring, row::bitstring, br::bitstring>>)
  end

  defp make_bitmap_row(rest, 0, acc) do
    {acc, rest}
  end

  defp make_bitmap_row(<<r, g, b, _a, rest::binary>>, w, acc) do
    white =
      if r > 200 or g > 200 or b > 200 do
        0
      else
        1
      end

    make_bitmap_row(rest, w - 1, <<acc::bitstring, white::size(1)>>)
  end

  @doc """
  Return paddings to constrain image width to modulo 32
  """
  def padding(width) do
    remain = rem(width, 32)
    halfborder = trunc((32 - rem(width, 32)) / 2)

    cond do
      remain == 0 ->
        {"", ""}

      rem(remain, 2) == 0 ->
        {<<0::size(halfborder)>>, <<0::size(halfborder)>>}

      true ->
        halfborder1 = halfborder + 1
        {<<0::size(halfborder)>>, <<0::size(halfborder1)>>}
    end
  end
end
