/*
 * Takes in the instruction and ALUOp and translate it into a aluControl used to
 * tell the ALU which mathematical operation to carry out.
 */ 
module ALUControl_m(
    output reg [3:0] aluControl,
    input[31:0] instruction, input[1:0]ALUOp);
    
    always@* begin
        casex({ALUOp, instruction[31:21]})
        //R-type
        13'b1010001011000: aluControl <= 4'b0010;//ADD instruction ADD aluControl
        13'b1011001011000: aluControl <= 4'b1010;//SUB instruction SUB aluControl
        13'b1010001010000: aluControl <= 4'b0110;//AND instruction AND aluControl
        13'b1010101010000: aluControl <= 4'b0100;//ORR instruction ORR aluControl
        13'b1011101010000: aluControl <= 4'b1001;//EOR instruction EOR aluControl

        //I-type
        13'b101001000100x: aluControl <= 4'b0010;//ADDI instruction ADD aluControl
        13'b101101000100x: aluControl <= 4'b1010;//SUBI instruction SUB aluControl
        13'b101001001000x: aluControl <= 4'b0100;//ANDI instruction AND aluControl
        13'b101011001000x: aluControl <= 4'b0100;//ORRI instruction ORR aluControl
        13'b101101001000x: aluControl <= 4'b1001;//EORI instruction EOR aluControl

        //D-type
        13'b0011111000010: aluControl <= 4'b0010;//LDR instruction ADD aluControl
        13'b0011111000000: aluControl <= 4'b0010;//STR instruction ADD aluControl

        //CB-type
        13'b0110110100xxx: aluControl <= 4'b0111;//CBZ instruction CBZ aluControl
        13'b0110110101xxx: aluControl <= 4'b1111;//CBNZ instruction CBNZ aluControl

        //M-Type
        13'b01111100101xx: aluControl <= 4'b1101;//MOVE instruction MOVE aluControl
        default: aluControl <= 4'b0000; //Unknown ALUOp and instruction combination
        endcase
    end
endmodule
