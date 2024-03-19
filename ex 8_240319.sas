LIBNAME Mysas 'D:\SAS 24-1\SAS_Data';

DATA mysas.htwt;
	INPUT name $ gender $ dept $ age height weight;
	LABEL name='이름' gender='성별';
CARDS;
김철수 M Stat 25 170 67
강민호 M Stat 20 169 70
이영희 F Math 19 160 58
박지수 F Econ 21 160 59
최명호 M Math 28 177 62
;
RUN;

PROC PRINT DATA=mysas.htwt;
RUN;
