// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

    @i
    M=1
    @R2
    M=0
    @R0
    D=M
    @R1
    D=D-M
    @GTR
    D;JGT
    @LSR
    0;JMP

(GTR)
    @x
    M=0
    @y
    M=1
    @LOOP
    0;JMP

(LSR)
    @x
    M=1
    @y
    M=0
    @LOOP
    0;JMP

(LOOP)
    @y
    A=M
    D=M
    @i
    D=M-D
    @END
    D;JGT

    @x
    A=M
    D=M
    @R2
    M=D+M
    @i
    M=M+1
    @LOOP
    0;JMP

(END)
    @END
    0;JMP