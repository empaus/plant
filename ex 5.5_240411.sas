DATA exam3;
	SET exam;
	IF mid IN (10 15) THEN score1='C';
	IF mid IN (20, 50) THEN score1='B';
	IF name IN ('ÀÌ¿µÈñ' '¹ÚÁö¼ö') THEN sex='F';
	IF name IN ('±èÃ¶¼ö','°­¹ÎÈ£') THEN sex='M';
RUN;
PROC PRINT;
RUN;
