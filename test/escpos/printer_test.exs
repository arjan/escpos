defmodule Escpos.PrinterTest do
  use ExUnit.Case

  alias Escpos.Printer

  test "printer from path" do
    [path | _] = Path.wildcard("/dev/usb/lp*")
    assert {:ok, %Printer{} = p} = Printer.from_path(path)

    Escpos.write(p, Escpos.Commands.TextFormat.txt_4square())
    Escpos.write(p, "\n\n\nHello!!\n\n\n\n\n")
    Escpos.write(p, Escpos.Commands.Paper.full_cut())

    assert(:ok = Printer.close(p))
  end

  test "printer from USB" do
    assert {:error, :device_not_found} = Printer.from_usb(123, 345)

    # Manufacturer: EPSON
    id_vendor = 0x04B8
    # Product: TM-T20II
    id_device = 0x0E15

    assert {:ok, %Printer{} = p} = Printer.from_usb(id_vendor, id_device)

    Escpos.write(p, Escpos.Commands.TextFormat.txt_4square())
    Escpos.write(p, "\n\n\nHello!!\n\n\n\n\n")
    Escpos.write(p, Escpos.Commands.Paper.full_cut())

    assert(:ok = Printer.close(p))
  end
end
