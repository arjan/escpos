defmodule Escpos.Printer do
  defstruct type: nil, handle: nil

  alias Escpos.Printer

  def from_path(path) do
    with {:ok, handle} <- File.open(path, [:write, :binary]) do
      {:ok, %Printer{type: :path, handle: handle}}
    end
  end

  def from_usb(id_vendor, id_device) do
    with {:ok, handle} <- LibUsb.get_handle(id_vendor, id_device) do
      {:ok, %Printer{type: :usb, handle: handle}}
    end
  end

  def close(%Printer{type: :path, handle: handle}) do
    :ok = File.close(handle)
  end

  def close(%Printer{type: :usb, handle: handle}) do
    :ok = LibUsb.release_handle(handle)
  end
end
