# Verilog Processor
## Team Members
* Matt
* Gary
* Tung

Verilog code for a 32-bit ARM verilog processor. The processor includes all components in a datapath.
ALU, AluControl, DataMemory, Decoder, InstructionMemory, Multiplexer, PC, Registers, and a test bench in order to monitor outputs.

All instructions are loaded in the instruction memory. Custom ones can be created following the ARMv8 instruction set. 
To use one of the instruction sets provided, comment one out, compile, and run. 
The number of clock cycles can be edited in the test bench. An instruction runs in 1 clock cycle.

To run using iverilog in command prompt:
    1) iverilog -o test.vvp test.v
    2) vvp test.vvp