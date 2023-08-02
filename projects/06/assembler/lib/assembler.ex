defmodule Assembler do
  @moduledoc """
  Documentation for `Assembler`.
  """

  alias Assembler.Parser, as: P
  alias Assembler.Code, as: C

  @predefined_symbols %{
    "R0" => "0",
    "R1" => "1",
    "R2" => "2",
    "R3" => "3",
    "R4" => "4",
    "R5" => "5",
    "R6" => "6",
    "R7" => "7",
    "R8" => "8",
    "R9" => "9",
    "R10" => "10",
    "R11" => "11",
    "R12" => "12",
    "R13" => "13",
    "R14" => "14",
    "R15" => "15",
    "SP" => "0",
    "LCL" => "1",
    "ARG" => "2",
    "THIS" => "3",
    "THAT" => "4",
    "SCREEN" => "16384",
    "KBD" => "24576"
  }

  def main(args) do
    [file_path] = args
    input_path = Path.expand(file_path)
    dir = Path.dirname(input_path)

    out_path =
      input_path
      |> Path.basename()
      |> then(&Regex.replace(~r/\.\w+/, &1, ".hack"))
      |> then(&Path.join(dir, &1))

    instructions =
      File.stream!(file_path)
      |> Stream.map(&P.parse/1)
      |> Enum.filter(& &1)

    symbols = build_symbol_table(instructions, 0, [], @predefined_symbols)

    instructions
    |> Stream.reject(&Keyword.has_key?(&1, :label))
    |> Stream.map(fn
      [type: :a, symbol: symbol] -> [type: :a, symbol: Map.get(symbols, symbol, symbol)]
      inst -> inst
    end)
    |> Stream.map(&C.from_instruction/1)
    |> Stream.map(&[&1, "\n"])
    |> Enum.to_list()
    |> then(&File.write!(out_path, &1))
  end

  def build_symbol_table([], _, vars, symbol_table) do
    vars
    |> Stream.reject(&Regex.match?(~r/^\d+$/, &1))
    |> Stream.reject(&Map.has_key?(symbol_table, &1))
    |> Stream.uniq()
    |> Enum.reverse()
    |> Enum.with_index(16)
    |> Enum.into(%{})
    |> Map.merge(symbol_table)
  end

  def build_symbol_table([[type: :a, label: label] | tl], idx, vars, symbol_table) do
    build_symbol_table(tl, idx, vars, Map.put_new(symbol_table, label, idx))
  end

  def build_symbol_table([[type: :a, symbol: symbol] | tl], idx, vars, symbol_table) do
    build_symbol_table(tl, idx + 1, [symbol | vars], symbol_table)
  end

  def build_symbol_table([_ | tl], idx, vars, symbol_table) do
    build_symbol_table(tl, idx + 1, vars, symbol_table)
  end
end
