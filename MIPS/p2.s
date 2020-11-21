;implement the following code:
;for(i=0; i<5; i++){
; for(j=0; j<5; j++){
;	v3[i][j] = v1[i][j] * v2[i][j];
;	v5[i][j] = v3[i][j] * v4[i][j];
;  }
;}
;where v1, v2, v4 are random 5x5 double matrices and v3, v5 are empty
;5x5 matrices. 
.data
  v1: .double 3.0, 0.2, 0.8, 0.8, 0.0, 2.0, 0.6, 0.2, 1.0, 3.0, 3.7, 3.7, 2.8, 0.3, 1.4, 1.3, 1.2, 3.2, 3.4, 2.8, 3.7, 3.2, 4.4, 0.9, 2.8
  v2: .double 2.1, 3.0, 3.6, 2.3, 0.5, 1.0, 4.0, 2.1, 4.3, 1.9, 4.2, 1.2, 2.7, 1.7, 4.3, 4.8, 2.7, 4.3, 2.3, 3.4, 4.8, 1.1, 0.3, 3.6, 0.7
  v4: .double 1.8, 1.0, 3.1, 4.3, 4.2, 3.1, 0.1, 3.6, 2.2, 3.3, 0.5, 4.9, 3.3, 1.1, 1.8, 1.8, 0.4, 0.5, 2.7, 4.2, 1.3, 3.4, 1.4, 4.7, 2.7 
  v3: .space 200
  v5: .space 200
.text
  and r6, r6, r0		;r6=0 (will be the index)
  FOR:
	l.d f1, v1(r6)		;r1 <- v1[r6]
	l.d f2, v2(r6)		;r2 <- v2[r6]
	l.d f4, v4(r6)		;r4 <- v4[r6]
	mul.d f3, f1, f2	;r3 = r1*r2
	s.d f3, v3(r6)		;save r3 inside v3
	mul.d f5, f3, f4	;r5 = r4*r3
	s.d f5, v5(r6)
	daddi r6, r6, 8		;r6++
	sltiu r7, r6, 200	;if(r6==25) r7=0
	bnez r7, FOR		;if(r7==0) -> END; else FOR
  halt
