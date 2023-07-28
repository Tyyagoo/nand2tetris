// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(SETUP)
    @SCREEN
    D=A
    @R0
    M=D
    @8192
    D=A
    @SCREEN
    D=D+A
    @R1
    M=D
    @POLLING
    0;JMP

(POLLING)
    @KBD
    D=M
    @WHITE
    D;JEQ
    @BLACK
    0;JMP


(WHITE)
    @R2
    M=0
    @FILL
    0;JMP

(BLACK)
    @R2
    M=-1
    @FILL
    0;JMP

(FILL)
    @R1
    D=M
    @R0
    D=D-M
    @SETUP
    D;JEQ

    @R2
    D=M
    @R0
    A=M
    M=D

    @R0
    M=M+1

    @POLLING
    0;JMP