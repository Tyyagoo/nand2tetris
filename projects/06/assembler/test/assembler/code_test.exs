defmodule Assembler.CodeTest do
  use ExUnit.Case
  alias Assembler.Code, as: C

  test "must handle numerical symbol" do
    assert "0000000100000000" = C.from_instruction(type: :a, symbol: "256")
  end

  test "must handle single attribution" do
    assert "1110110000010000" = C.from_instruction(type: :c, comp: "A", dest: "D", jump: nil)
  end

  test "must handle multiple attribution with operation" do
    assert "1111110010101000" = C.from_instruction(type: :c, comp: "M-1", dest: "MA", jump: nil)
  end

  test "must handle inconditional jump" do
    assert "1110101010000111" = C.from_instruction(type: :c, comp: "0", dest: "", jump: "JMP")
  end

  test "must handle conditional jump" do
    assert "1110001100000110" = C.from_instruction(type: :c, comp: "D", dest: "", jump: "JLE")
  end
end
