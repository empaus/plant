DATA exam;
	INPUT id $ name $ mid final;
CARDS;
001 김철수 10 40
002 이영희 15 10
001 강민호 50 15
001 박지수 20 . 
;
RUN;
PROC PRINT;
RUN;

DATA exam1;
	SET exam;
	x=30;
	major='통계학';
	major_id='STA'||id;    
	mean=(mid+final)/2;
	y=mid**3;
	LABEL name='이름' mid='중간성적' final='기말성적';
RUN;
PROC PRINT;
RUN;
