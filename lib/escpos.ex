defmodule Escpos do
  @moduledoc """
  Documentation for Escpos.
  """

  alias Escpos.Printer
  alias Escpos.Image

  def write(%Printer{type: :path, handle: handle}, data) do
    IO.binwrite(handle, data)
  end

  def write(%Printer{type: :usb, handle: handle}, data) do
    LibUsb.bulk_send(handle, 1, data, 100_000)
  end

  def write_image_file(printer, path) do
    {:ok, pixels} = Pixels.read_file(path)

    data = Image.pixels_to_bitmap(pixels)
    write(printer, data)
  end

  def write_image_data(printer, data) do
    with {:ok, pixels} <- Pixels.read(data) do
      data = Image.pixels_to_bitmap(pixels)
      write(printer, data)
    end
  end
end
