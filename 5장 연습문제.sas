/*연습문제 1번*/
DATA temper1;
	DO obs=1 TO 10;
			fahren=INT(RANUNI(0)*181+32);
			OUTPUT;
	END;
	DROP obs;
RUN;
PROC PRINT;
RUN;
DATA temper2;
	SET temper1;
	celsius=(5/9)*(fahren-32);
PROC PRINT;
RUN;



/*연습문제 2번*/
DATA exam5_2;
	INPUT id $ q1-q6;
	small=MIN(OF q1 q6);
	big=MAX(q1,q2,q3,q4,q5,q6);
	mean=MEAN(OF q1-q6);

CARDS;
001 3 2 5 4 4 3
002 .  2 1 2 1 2
003 5 3 4 4 .  5
;
RUN;
PROC PRINT;
RUN;

/*연습문제 4번*/
DATA exam5_4;
	INPUT id x1-x3;
CARDS;
2 21 22 23
5 51 52 53
5 51 52 53
1 11 12 13
3 31 32 33
3 31 32 33
4 41 42 43
;
RUN;
PROC SORT DATA=exam5_4;
	BY id;
RUN;
DATA nexam5_4;
	SET exam5_4;
	RETAIN oldid 0;
	IF id=oldid THEN DELETE;
	oldid=id;
	DROP oldid;
RUN;
PROC PRINT;
RUN;

/*연습문제 5번*/
DATA exam5_5;
	INPUT x1-x5 a b c d y1-y5 z1-z3;
	ARRAY var [17] x1-x5 a b c d y1-y5 z1-z3;
	DO i=1 TO 5;
		IF var(i)=9 THEN var(i)=.;
	END;
	DO i=6 TO 9;
		IF var(i)=99 THEN var(i)=.;
	END;
    DO; i=10 TO 17; 
		IF var(i)=999 THEN var(i)=.;
	END;
	
CARDS;
1 0 1 01 2 2 2 2 1 2 3 4 5 3 3 3
9 0 0 0 9 99 99 99 7 999 4 5 6 999 999 999
;
RUN;
PROC PRINT;
RUN;

/*연습문제 8번*/
DATA exam5_8;
	INPUT PROJECT_ID StartDate Date9. +1 EndDate Date9.;
	period=EndDate-StartDate;
	FORMAT StartDate Date9. EndDate Date9.;
CARDS;
398  17mar2007 02nov2007
942  22jan2008  11jul2008
167  15aug2009  15feb2010
250  04jan2011 11dec2011
;
RUN;
PROC PRINT;
RUN;
