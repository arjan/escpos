defmodule Escpos.PrinterTest do
  use ExUnit.Case

  @path Path.wildcard("/dev/usb/lp*") |> List.first()

  alias Escpos.Printer

  test "printer" do
    assert {:ok, %Printer{} = p} = Printer.open(@path)

    Escpos.write(p, Escpos.Commands.TextFormat.txt_4square())
    Escpos.write(p, "\n\n\nHello!!\n\n\n\n\n")
    Escpos.write(p, Escpos.Commands.Paper.full_cut())

    assert(:ok = Printer.close(p))
  end
end
