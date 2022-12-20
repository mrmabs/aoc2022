10 DIM M$(255)
20 LET L=0
30 LET SX=0
40 LET SY=0
50 LET EX=0
60 LET EY=0

80 OPEN "I", 1, "INPUT.TXT"
90 PRINT "Reading and Scanning data..."

100 IF EOF(1) GOTO 300
110 LINE INPUT#1, LI$
120 LET COLS=LEN(LI$)
130 FOR I%=1 TO LEN(LI$)
140 LET C$=MID$(LI$, I%, 1)
150 IF C$="S" THEN GOSUB 200
160 IF C$="E" THEN GOSUB 250
170 NEXT I%
180 LET M$(L)=LI$ : LET L=L+1
190 GOTO 100

200 LET SX=1
210 LET SY=24
220 RETURN

250 LET EX=I%
260 LET EY=L
270 RETURN

300 PRINT "DONE"
310 PRINT "Lines read:", L
320 PRINT "S:", SX, SY
330 PRINT "E:", EX, EY
340 CLOSE 1

400 REM create a direction maps so we can calc the shortest path
410 DIM N%(COLS, L)
420 REM create a queue, we manage this in the GOSUBs at 2000 & 2200
430 DIM Q%(384, 2)

500 PRINT "Flooding map..."
510 LET H%=ASC("a")
520 LET MAXH%=H%
530 LET X%=SX
540 LET Y%=SY
550 LET N%(0,0)=1

600 REM add to queue
610 REM PRINT "Cheking:", X%, Y%
620 REM IF (X%=EX) and (Y%=EY) GOTO 900
630 REM up
640 LET D%=1
650 LET CX=X%
660 LET CY=Y% - 1
670 IF (CX=EX) and (CY=EY) GOTO 900
680 GOSUB 2200
690 REM down
700 LET D%=2
710 LET CX=X%
720 LET CY=Y% + 1
730 IF (CX=EX) and (CY=EY) GOTO 900
740 GOSUB 2200
750 REM left
760 LET D%=3
770 LET CX=X% - 1
780 LET CY=Y%
790 IF (CX=EX) and (CY=EY) GOTO 900
800 GOSUB 2200
810 REM right
820 LET D%=4
830 LET CX=X% + 1
840 LET CY=Y%
850 IF (CX=EX) and (CY=EY) GOTO 900
860 GOSUB 2200
870 REM grab next on queue
880 GOSUB 2000
890 GOTO 610

900 PRINT "At end"
910 REM OPEN "O", 2, "PATH.TXT"
920 REM walk back to start
930 LET STEPS=1
950 IF (X%=SX) AND (Y%=SY) THEN 1100
960 PRINT X%, Y%, MID$(M$(Y%), X%+1, 1)
980 IF N%(X%, Y%)=1 THEN LET Y%=Y% + 1 : STEPS=STEPS + 1 : GOTO 950
990 IF N%(X%, Y%)=2 THEN LET Y%=Y% - 1 : STEPS=STEPS + 1 : GOTO 950
1000 IF N%(X%, Y%)=3 THEN LET X%=X% + 1 : STEPS=STEPS + 1 : GOTO 950
1010 IF N%(X%, Y%)=4 THEN LET X%=X% - 1 : STEPS=STEPS + 1 : GOTO 950
1020 PRINT "Fail"
1030 GOTO 1110

1100 PRINT "Steps = " STEPS 
1110 REM CLOSE 2
1120 END

2000 REM unshift
2010 PRINT "Unshift", Q%(0,0) Q%(0,1), MID$(M$(Y%+1), X%+1, 1) " <= " CHR$(MAXH%)
2011 REM , sqr((abs(Q%(0,0)-EX)^2)+(abs(Q%(0,1)-EY)^2))
2020 REM Empty buffer, oops
2030 IF (X%=Q%(0,0)) and (Y%=Q%(0,1)) then end
2040 LET X%=Q%(0,0)
2050 LET Y%=Q%(0,1)
2060 LET H%=ASC(MID$(M$(Y%), X%+1, 1))
2070 IF H%>MAXH% THEN LET MAXH%=H%
2080 FOR I%=0 TO 383
2090 LET Q%(I%, 0)=Q%(I% + 1, 0)
2100 LET Q%(I%, 1)=Q%(I% + 1, 1)
2110 NEXT I%
2120 LET Q%(384, 0)=0
2130 LET Q%(384, 1)=0
2140 LET QL=QL - 1
2150 RETURN

2200 REM insert
2210 REM PRINT "Insert", CX, CY
2220 REM I am a bad person with bad programming practices; 0,0 should be valid
2230 REM IF (CX=0) and (CY=0) THEN 2480
2240 IF (CX<0) or (CY<0) or (CX>=COLS) or (CY>=L) THEN 2480
2250 IF N%(CX, CY)>0 then 2480
2260 LET OH%=ASC(MID$(M$(CY), CX+1, 1))
2270 IF OH%=69 THEN OH%=122
2280 IF OH% > (H%+1) GOTO 2480
2290 REM LET DIST!=sqr((abs(CX-EX)^2)+(abs(CY-EY)^2))
2300 LET COUNT%=0
2310 IF COUNT%>384 GOTO 2480
2325 IF (Q%(COUNT%,0)=CX) and (Q%(COUNT%,1)=CY) THEN 2480
2330 IF (Q%(COUNT%,0)=0) and (Q%(COUNT%,1)=0) THEN 2430
2340 REM LET THIS!=sqr((abs(Q%(COUNT%,0)-EX)^2)+(abs(Q%(COUNT%,1)-EY)^2))
2350 REM IF DIST!<THIS! GOTO 2390
2360 LET COUNT%=COUNT% + 1
2370 GOTO 2310
2380 REM shift and furthest drop off
2390 FOR I%=255 TO COUNT% STEP -1
2400 LET Q%(I% + 1, 0)=Q%(I%, 0)
2410 LET Q%(I% + 1, 1)=Q%(I%, 1)
2420 NEXT I%
2430 LET Q%(COUNT%, 0)=CX
2440 LET Q%(COUNT%, 1)=CY
2450 LET N%(CX, CY)=D%
2460 LET QL=QL+1
2470 REM PRINT "Adding to queue:", CX, CY
2480 RETURN



