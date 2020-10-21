;given two arrays (a, b) of 30 integers, and an empty one (c), compute each element of c as:
; c[i] = 4*(a[i] + b[i])
;then search for the maximum and the minimum into array c, and store them into mem
.data 
  a: .word16 7, -1, -5, 8, -14, 11, 9, 8, 5, -5, 5, 12, 0, -3, -9, -1, 13, 10, 13, 11, 3, 0, 11, 9, 13, -2, 3, 6, 1, 3
  b: .word16 14, -6, 1, 9, 0, -5, 13, -3, -4, 7, 6, 6, 12, 6, 8, 3, 8, 7, 9, 0, 8, -2, 6, 5, 9, -1, 6, 13, 4, 10
  c: .space 60			;i.e. 30 half words
  len: .word16 30
  max: .word16 1
  min: .word16 1
.text
  ld R6, len(R0)		;R6 <- len
  and R2, R0, R0		;R2 = 0	(R2 is the index of c)
  dsll R1, R6, 1		;R1 = 2*len (R1 is the index of a and b)
  FOR:
	daddi R1, R1, -2	;R1 = R1-2 
	lh R3, a(R1)		;R3 <- a(R1)
	lh R4, b(R1)		;R4	<- b(R1)
	dadd R5, R3, R4		;R5 = R3 + R4
	dsll R6, R5, 2		;R6 = 4*R5
	sh R6, c(R2)		;save the result in c
	daddi R2, R2, 2		;R2 = R2+2
	bnez R1, FOR
  lh R1, len(R0)		;use R1 as index
  dsll R1, R1, 1		;R1 *= 2
  daddi R1, R1, -2
  lh R2, c(R1)			;use R2 as current min
  or R3, R2, R0			;use R3 as current max
  SEARCH:
	daddi R1, R1, -2	;decrement R1
	lh R4, c(R1)		;load the next value into R4
	slt R5, R4, R2		;if (R4 < R2) => R4 is the new min
	slt R6, R3, R4		;if (R4 > R3) => R4 is the new max
	bnez R5, UPDATEMIN
	bnez R6, UPDATEMAX
	bnez R1, SEARCH
	beqz R1, END
  UPDATEMIN:
	or R2, R4, R0		;write the new min into R2
	bnez R6, UPDATEMAX	
  bnez R1, SEARCH
	beqz R1, END
  UPDATEMAX:
	or R3, R4, R0		;write the new max into R3
	bnez R1, SEARCH
  END: 
	sh R2, min(R0)
	sh R3, max(R0)
  halt
