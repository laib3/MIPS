;branch delay slot version (no optimization)
.data 
  a: .word16 7, -1, -5, 8, -14, 11, 9, 8, 5, -5, 5, 12, 0, -3, -9, -1, 13, 10, 13, 11, 3, 0, 11, 9, 13, -2, 3, 6, 1, 3
  b: .word16 14, -6, 1, 9, 0, -5, 13, -3, -4, 7, 6, 6, 12, 6, 8, 3, 8, 7, 9, 0, 8, -2, 6, 5, 9, -1, 6, 13, 4, 10
  c: .space 60			;i.e. 30 half words
  len: .word16 30
  max: .word16 1
  min: .word16 1
.text
PART_I:
  ld r6, len(r0)		;r6 <- len
  and r2, r0, r0		;r2 = 0	(r2 is the index of c)
  dsll r1, r6, 1		;r1 = 2*len (r1 is the index of a and b)
  daddi r1,r1,-2		;r1 = r1-2
  FOR:
	lh r3, a(r1)		;r3 <- a(r1)
	lh r4, b(r1)		;r4	<- b(r1)
	dadd r5, r3, r4		;r5 = r3 + r4
	dsll r6, r5, 2		;r6 = 4*r5
	sh r6, c(r2)		;save the result in c
	daddi r2, r2, 2		;r2 = r2+2
	bnez r1, FOR
	daddi r1, r1,-2		;use branch delay slot

PART_II:
	lh r1, len(r0)		;use r1 as index
	dsll r1, r1, 1		;r1 *= 2
	lh r2, c(r1)		;use r2 as current min
	or r3, r2, r0		;use r3 as current max

	;do it for the first value
	daddi r1,r1,-2		;decrement r1
	lh r4,c(r1)			;load next value
	slt r5,r4,r2		;set min flag 
	slt r6,r3,r4		;set max flag (branch delay slot)
	
  UPDATEMIN:
	beqz r5,UPDATEMAX
	daddi r1,r1,-2		;fill branch delay slot
	or r2,r4,r0			;set current min
	
  UPDATEMAX:
	beqz r6,SEARCH
	nop					;fill branch delay slot
	or r3,r4,r0			;set current max

  SEARCH:
	lh r4, c(r1)		;load the next value into r4
	slt r5, r4, r2		;if (r4 < r2) => r4 is the new min
	slt r6, r3, r4		;if (r4 > r3) => r4 is the new max
	bnez r1,UPDATEMIN
	nop					;fill branch delay slot
	
  END: 
	sh r2, min(r0)
	sh r3, max(r0)
  halt
