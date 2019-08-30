defmodule EscposTest do
  use ExUnit.Case
  doctest Escpos

  alias Escpos.Printer
  alias Escpos.Commands

  @path Path.wildcard("/dev/usb/lp*") |> List.first()

  alias Escpos.Printer

  test "printer" do
    assert {:ok, %Printer{} = p} = Printer.from_path(@path)

    # Escpos.write_image(p, "test/hello.jpg")
    #    Escpos.write(p, Commands.Hardware.reset())
    #    Escpos.write(p, Commands.TextFormat.txt_normal())
    Escpos.write_image_file(p, "test/t.png")

    Escpos.write(p, "\n\n\n\n")
    Escpos.write(p, Commands.Paper.full_cut())

    :ok = Printer.close(p)
  end
end
