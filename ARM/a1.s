;write a program which compares the parity of R0 to the parity of R1
;(the parity is odd if the number of bits set to 1 is odd, otherwise is even)
;if R0 and R1 have the same parity the program copies the value of the flags into R1;
;else if R0 and R1 have different parity the program sets the 8MSB of R0 to 0 and the 8LSB of R0 to 1.

				MOV R0, #0x80000000
				MOV R1, #0x00000001
				MOV R2, #32					;R2 is the counter (repeat for each bit)
				MOV R5, #0x01				;R5 is the mask
for				ANDS R3, R0, R5				;R3 = R0 AND mask
				ADDNE R6, R6, #1			;R0_parity ++
				ANDS R4, R1, R5				;R4 = R1 AND mask
				ADDNE R7, R7, #1			;R1_parity ++
				LSL R5, R5, #1				;shift mask to left
				SUB R2, R2, #1				;R2--
				CBZ R2, endfor				;if(R2==0) end
				B for	
endfor			AND R8, R6, #0x01			;if(R0_parity == odd) set R8
				AND R9, R7, #0x01			;if(R1_parity == odd) set R9
				TEQ R8, R9			
				MRSNE R1, APSR				;if(R0_parity != R1_parity) copy flags in R1
				BNE exit		
				AND R0, R0, #0x00FFFFFF		;else set 8MSB to 0
				ORR R0, R0, #0x000000FF		;and set 8LSB to 1
exit			
