defmodule EscposTest do
  use ExUnit.Case
  doctest Escpos

  alias Escpos.Printer

  @path Path.wildcard("/dev/usb/lp*") |> List.first()

  alias Escpos.Printer

  test "printer" do
    assert {:ok, %Printer{} = p} = Printer.open(@path)

    # Escpos.write_image(p, "test/hello.jpg")
    Escpos.write(p, "hello\n")
    # Escpos.write_image(p, "test/dot.png")

    :ok = Printer.close(p)
  end
end
