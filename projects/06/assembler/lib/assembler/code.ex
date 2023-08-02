defmodule Assembler.Code do
  def from_instruction(instruction) do
    instruction
    |> Enum.map(fn {type, value} -> apply(__MODULE__, type, [value]) end)
    |> Enum.join()
  end

  def type(:a), do: "0"
  def type(:c), do: "111"

  def symbol(value), do: decimal_to_binary(value)

  def comp("0"), do: "0101010"
  def comp("1"), do: "0111111"
  def comp("-1"), do: "0111010"
  def comp("D"), do: "0001100"
  def comp("A"), do: "0110000"
  def comp("M"), do: "1110000"
  def comp("!D"), do: "0001101"
  def comp("!A"), do: "0110001"
  def comp("!M"), do: "1110001"
  def comp("-D"), do: "0001111"
  def comp("-A"), do: "0110011"
  def comp("-M"), do: "1110011"
  def comp("D+1"), do: "0011111"
  def comp("A+1"), do: "0110111"
  def comp("M+1"), do: "1110111"
  def comp("D-1"), do: "0001110"
  def comp("A-1"), do: "0110010"
  def comp("M-1"), do: "1110010"
  def comp("D+A"), do: "0000010"
  def comp("D+M"), do: "1000010"
  def comp("D-A"), do: "0010011"
  def comp("D-M"), do: "1010011"
  def comp("A-D"), do: "0000111"
  def comp("M-D"), do: "1000111"
  def comp("D&A"), do: "0000000"
  def comp("D&M"), do: "1000000"
  def comp("D|A"), do: "0010101"
  def comp("D|M"), do: "1010101"

  def dest(d) do
    Enum.join([
      if(String.contains?(d, "A"), do: "1", else: "0"),
      if(String.contains?(d, "D"), do: "1", else: "0"),
      if(String.contains?(d, "M"), do: "1", else: "0")
    ])
  end

  def jump(nil), do: "000"
  def jump("JGT"), do: "001"
  def jump("JEQ"), do: "010"
  def jump("JGE"), do: "011"
  def jump("JLT"), do: "100"
  def jump("JNE"), do: "101"
  def jump("JLE"), do: "110"
  def jump("JMP"), do: "111"

  @spec decimal_to_binary(binary | integer) :: binary
  def decimal_to_binary(n) when is_binary(n) do
    n
    |> String.to_integer()
    |> decimal_to_binary()
  end

  def decimal_to_binary(n) when is_integer(n) do
    n
    |> Integer.to_string(2)
    |> String.pad_leading(15, "0")
  end
end
