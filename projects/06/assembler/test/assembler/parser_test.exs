defmodule Assembler.ParserTest do
  use ExUnit.Case
  alias Assembler.Parser, as: P

  test "must handle numerical symbol" do
    assert [type: :a, symbol: "256"] = P.parse("@256")
  end

  test "must handle reference symbol" do
    assert [type: :a, symbol: "abc"] = P.parse("@abc")
  end

  test "must handle reference to predefined symbol" do
    assert [type: :a, symbol: "SCREEN"] = P.parse("@SCREEN")
  end

  test "must handle inconditional jump instruction" do
    assert [type: :c, comp: "0", dest: "", jump: "JMP"] = P.parse("0;JMP")
  end

  test "must handle conditional jump instruction" do
    assert [type: :c, comp: "D", dest: "", jump: "JNE"] = P.parse("D;JNE")
  end

  test "must handle simple attribution" do
    assert [type: :c, comp: "D", dest: "A", jump: nil] = P.parse("A=D")
  end

  test "must handle multiple attribution" do
    assert [type: :c, comp: "D", dest: "MA", jump: nil] = P.parse("MA=D")
  end

  test "must handle decrement" do
    assert [type: :c, comp: "-1", dest: "M", jump: nil] = P.parse("M=-1")
  end

  test "must handle operation" do
    assert [type: :c, comp: "M-1", dest: "AM", jump: nil] = P.parse("AM=M-1")
  end
end
