DATA exam;
	INPUT id $ name $ mid final;
CARDS;
001 ��ö�� 10 40
002 �̿��� 15 10
001 ����ȣ 50 15
001 ������ 20 . 
;
RUN;

DATA exam2;
	SET exam;
	IF final=. THEN final=10;
	IF (mid+final)>=50 THEN score1='P';
	IF mid>=30 or final>=30 THEN score2='P';
	IF score1=' ' THEN
		DO;
			score1='F';
			score2='F';
		END;
RUN;
PROC PRINT;
RUN;
