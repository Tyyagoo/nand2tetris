defmodule Assembler.Parser do
  @syntax ~r/(((\((?<label>[\w_$\.]+)\))|@(?<symbol>[\w_$\.]+))|(?<dest>[AMD0]+)(=(?<comp>[!&|01A-Za-z\-+]+)|;(?<jump>\w+)))/

  @spec parse(String.t()) :: Keyword.t()
  def parse(instruction) do
    case Regex.named_captures(@syntax, instruction) do
      %{"label" => label} when byte_size(label) > 0 ->
        [type: :a, label: label]

      %{"symbol" => symbol} when byte_size(symbol) > 0 ->
        [type: :a, symbol: symbol]

      %{"dest" => dest, "comp" => comp} when byte_size(comp) > 0 ->
        [type: :c, comp: comp, dest: dest, jump: nil]

      %{"dest" => dest, "jump" => jump} when byte_size(jump) > 0 ->
        [type: :c, comp: dest, dest: "", jump: jump]

      _ ->
        nil
    end
  end
end
