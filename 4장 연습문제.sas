DATA exam4_4;
	INPUT id $ dept $ age test1 test2 gender $;
CARDS;
001 stat 22 9 12 m
002 law 21 10 15 f
003 econ 23 10 17 f
004 math 27 16 17 m
005 engl 21 11 12 f
;
RUN;

DATA exam4_5;
	INFILE 'C:\SAS24-1\exam4_5.txt'FIRSTOBS=3;
	INPUT id 1-3 name $ 5-13 item1 16 item2 17 item3 18 item4 19 
		  item5 20 item6 21 height 22-24 weight 25-26 age 27-28
		  region $ 30-38;
PROC PRINT;
RUN;

DATA exam4_6;/*formatted input¹® »ç¿ë*/
	INFILE 'C:\SAS24-1\exam4_5.txt'FIRSTOBS=3;
	INPUT id 3.	+1 name $9. @16 (item1-item6)(1.)  
          height 3. weight 2. age 2. +1 region $9.;
		  
PROC PRINT;
RUN;


/*4-7*/
DATA exam4_4;
	INPUT id $ dept $ age test1 test2 gender $;
CARDS;
001,stat,22,9,12,m
002,law,21,10,15,.
003,"econ",23,.17,f
004,math,27,16,17,"m"
."engl",21,11,12,"f"
;
RUN;
PROC PRINT;
RUN;


/*4-8*/
DATA exam4_8;
	INFILE 'C:\SAS24-1\sales.txt' FIRSTOBS=3;
	INPUT machine $ 29-30 @;
	IF machine='sm' THEN INPUT name $ 1-8 gender $ 9 sales 10-14 region $ 20-24 ;
	IF machine='c'  THEN INPUT name $ 1-8 region $ 10-14 sales 16-20 gender $ 21 age 22-23;
RUN;
PROC PRINT;
RUN;


/*4-9*/
DATA exam4_9;
	INPUT last $ first $ gender $ math engl @@;
CARDS;
LEE SEULGI F 58.9 77.8 PARK SOEUN F 91.0 82.6 CHAE YOUNSIK M 67.7 45.9
KIM EUNYOUNG F 63.5 78.1 CHO MINJI M 34.2 67.8 PARK INSOO M 45.6 53.4
;
RUN;
PROC PRINT;
RUN;
