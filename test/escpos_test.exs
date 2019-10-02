defmodule EscposTest do
  use ExUnit.Case
  doctest Escpos

  alias Escpos.Printer
  alias Escpos.Commands

  # Manufacturer: EPSON
  @id_vendor 0x04B8
  # Product: TM-T20II
  @id_device 0x0E15

  alias Escpos.Printer

  test "printer" do
    assert {:ok, %Printer{} = p} = Printer.from_usb(@id_vendor, @id_device)

    # Escpos.write_image(p, "test/hello.jpg")
    #    Escpos.write(p, Commands.Hardware.reset())
    #    Escpos.write(p, Commands.TextFormat.txt_normal())
    Escpos.write_image_file(p, "test/t.png")

    Escpos.write(p, "\n\n\n\n")
    Escpos.write(p, Commands.Paper.full_cut())

    :ok = Printer.close(p)
  end

  test "invalid image data" do
    assert {:ok, %Printer{} = p} = Printer.from_usb(@id_vendor, @id_device)

    assert {:error, :invalid_data} = Escpos.write_image_data(p, "asdf")

    :ok = Printer.close(p)
  end
end
