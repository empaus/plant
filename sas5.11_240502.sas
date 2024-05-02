DATA tscore;
	INPUT name $ math stat eng kor art;
	ARRAY tscore [5] math stat eng kor art;
	DO i=1 TO 5;
		IF tscore(i)=9 THEN tscore(i)=.;
	END
;
CARDS;
김철수 5 5 1 2 1
최민지 9 3 1 4 5
이영희 1 5 3 2 9
오인수 4 1 2 4 9
;
RUN;
PROC PRINT;
RUN;
