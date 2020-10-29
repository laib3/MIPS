;implement the following piece of code:
;unsigned char a[30];
;unsigned char b[30];
;unsigned char res[30];
;
;for(i=0; i<30; i++){
;  while(b[i] > 0){
;	if(isOdd(b[i])){
;	  res[i] = res[i] + a[i];
;	}
;
;	a[i] = a[i] * 2;
;	b[i] = b[i] / 2;
;  }
;}

.data
  a: .word32 0, 3, 1, 3, 3, 2, 4, 5, 4, 5, 4, 1, 3, 3, 4, 3, 3, 1, 4, 2, 1, 5, 4, 2, 5, 1, 1, 3, 0, 0
  b: .word32 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0
  res: .space 120
.text
  and R4, R4, R0	;use R4 as index
  WHILE: 
	lwu R2, b(R4)		;R2 = a[i]
	lwu R1, a(R4)		;R1 = a[i]
	lwu R6, res(R4)		;R6 = res[i]
	beqz R2, UPDATE		;if(b==0) break
	andi R5, R2, 0x01	;R5 = isOdd(R2) = isOdd(b[i])
	beqz R5, E			;if(R5==0) b is even
	dadd R8, R6, R1		;R8 = a[i] + res[i]
	sw R8, res(R4)		;save R8 into res
  E:
	dsll R1, R1, 1		;a[i] = a[i]*2
	dsrl R2, R2, 1		;b[i] = b[i]/2
	sw R1, a(R4)		;save R1 into res
	sw R2, b(R4)		;save R2 into b
	j WHILE			  
  UPDATE:
	daddi R4, R4, 4		;i++
	sltiu R7, R4, 120	;if(i<30) R7 = 1
	bnez R7, WHILE		
  halt
