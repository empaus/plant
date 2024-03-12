
DATA ex1_1;
	INFILE 'D:\SAS24-1\score.txt';
	INPUT id $ 1-3 name $ 5-10 $ sex $ 13
	weight 16-17 height 19-21;
RUN;

PROC MEANS DATA = ex1_1;
	VAR weight height;
RUN;

DATA ex1_2;
	SET ex1_1;
	IF weight>=70 THEN weight1 = 'GE70';
		ELSE weight1='LT70';
RUN;

PROC print DATA = ex1_2;
	VAR name weight weight1;
RUN;

PROC CHART DATA=ex1_2;
	VBAR weight1;
RUN;
