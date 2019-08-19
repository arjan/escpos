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
    {:ok, {w, h, pixels}} = Imago.read_pixels(path)
    IO.inspect(pixels, label: "pixels")

    data = Image.pixels_to_bitmap(w, h, pixels)
    IO.inspect(data, label: "data")

    write(printer, data)
  end
end
