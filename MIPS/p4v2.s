;optimize the program p4.s by rescheduling the instructions 
;in order to eliminate as much hazards as possible.

.data
  v1: .double 2.3, 2.8, 2.0, 0.6, 4.8, 2.0, 4.5, 4.1, 4.2, 2.7, 2.6, 4.5, 2.7, 2.3, 2.1, 4.4, 1.3, 2.1, 2.8, 4.7, 4.3, 0.5, 3.2, 3.7, 3.7, 4.0, 3.5, 3.8, 0.9, 4.9
  v2: .double 4.3, 3.1, 0.5, 4.3, 1.9, 3.4, 2.8, 2.1, 0.0, 3.1, 4.9, 2.5, 0.1, 3.0, 0.2, 0.2, 1.8, 2.1, 2.7, 2.4, 2.2, 1.6, 0.2, 3.9, 3.4, 2.7, 2.2, 2.0, 4.7, 1.5
  v3: .double 4.1, 1.2, 0.7, 2.7, 1.1, 2.7, 3.5, 0.3, 3.0, 2.4, 1.4, 3.4, 3.0, 3.3, 2.9, 4.7, 5.0, 4.0, 1.0, 0.4, 3.2, 2.6, 0.7, 1.9, 1.1, 3.1, 0.4, 3.0, 3.3, 2.1
  v4: .double 1.0, 3.4, 3.4, 3.0, 4.5, 4.4, 1.9, 4.7, 4.4, 2.9, 2.2, 0.8, 2.9, 3.9, 1.0, 3.6, 3.3, 1.8, 0.2, 0.3, 1.8, 2.6, 4.7, 2.7, 4.7, 3.6, 4.7, 2.9, 3.3, 0.9
  v5: .space 240
  v6: .space 240
  v7: .space 240
.text
  daddi R1, R0, 0	  ;set index to position 0
LOOP:
  l.d F1, v1(R1)	  
  l.d F2, v2(R1)
  l.d F3, v3(R1)
  l.d F5, v4(R1)	  
  sub.d F4, F1, F2	  ;F4 = v1[i] - v2[i]
  mul.d F4, F4, F3	  ;F4 = (v1[i] - v2[i]) * v3[i]
  s.d F4, v5(R1)	  ;v5[i] = (v1[i] - v2[i]) * v3[i]
  mul.d F4, F4, F3	  ;F4 = v5[i] * v3[i]
  s.d F4, v6(R1)	  ;v6[i] = v5[i] * v3[i]
  add.d F4, F4, F5	  ;F4 = v4[i] + v6[i]
  mul.d F4, F4, F2	  ;F4 = (v4[i] + v6[i]) * v2[i]
  s.d F4, v7(R1)	  ;v7[i] = (v4[i] + v6[i]) * v2[i] 
  daddi R1, R1, 8	  ;increment index
  daddi R2, R1, -240  ;if(R1 < 240) R2 = 1
  bnez R2, LOOP		  
  halt
  

