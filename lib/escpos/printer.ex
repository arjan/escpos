defmodule Escpos.Printer do
  defstruct type: nil, fp: nil

  alias Escpos.Printer

  def open(path) do
    with {:ok, fp} <- File.open(path, [:write, :binary]) do
      {:ok, %Printer{type: :path, fp: fp}}
    end
  end

  def close(%Printer{type: :path, fp: fp}) do
    File.close(fp)
  end
end
