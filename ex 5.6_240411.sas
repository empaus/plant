DATA exam4;
	SET exam;
	IF mid>=30 THEN score1='A';/*if�� ��ø�ؼ� ��밡��*/ 
		ELSE IF mid>=20 THEN score1='B';/*ELSE ���� �������� �ٷ� ���� ELSE IF��*/
		ELSE score1='C';
	IF final>=30 THEN score2='P';
		ELSE score2='F';
RUN;
PROC PRINT;
RUN;
