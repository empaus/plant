DATA exam3;
	SET exam;
	IF mid IN (10 15) THEN score1='C';
	IF mid IN (20, 50) THEN score1='B';
	IF name IN ('�̿���' '������') THEN sex='F';
	IF name IN ('��ö��','����ȣ') THEN sex='M';
RUN;
PROC PRINT;
RUN;
