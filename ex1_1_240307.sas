DATA ex1_1;
	INPUT id $ 1-3 name $ 5-10 sex $ 13
		  weight 16-17 height 19-21;
	If weight>=70 THEN weight1='GE70';
		ELSE weight1='LT70';
CARDS;
101 김철수 M 74 170
102 이영희 F 68 166
103 안수지 F 55 155
104 박민호 M 72 167
105        M 66 169
106 강지영 F 62   .
;
RUN;

PROC PRINT DATA=ex1_1;
RUN;

/*통계량의 계산*/
PROC MEANS DATA = ex1_1;
	VAR weight height; /*변수들에 대한 표본분산 보기*/
RUN;

PROC UNIVARIATE DATA=ex1_1;
	VAR weight height;
RUN;
