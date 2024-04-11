DATA exam4;
	SET exam;
	IF mid>=30 THEN score1='A';/*if문 중첩해서 사용가능*/ 
		ELSE IF mid>=20 THEN score1='B';/*ELSE 문의 대응문은 바로 앞의 ELSE IF문*/
		ELSE score1='C';
	IF final>=30 THEN score2='P';
		ELSE score2='F';
RUN;
PROC PRINT;
RUN;
