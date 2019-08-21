defmodule Escpos do
  @moduledoc """
  Documentation for Escpos.
  """

  alias Escpos.Printer
  alias Escpos.Image

  def write(%Printer{fp: fp}, data) when is_pid(fp) do
    IO.binwrite(fp, data)
  end

  def write_image(printer, path) do
    {:ok, pixels} = Pixels.read_file(path)

    data = Image.pixels_to_bitmap(pixels)
    dd = Base.encode16(data) |> String.to_charlist() |> Enum.chunk_every(8)
    IO.inspect(dd, label: "data")

    write(printer, data)
  end
end
