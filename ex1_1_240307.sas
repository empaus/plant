DATA ex1_1;
	INPUT id $ 1-3 name $ 5-10 sex $ 13
		  weight 16-17 height 19-21;
	If weight>=70 THEN weight1='GE70';
		ELSE weight1='LT70';
CARDS;
101 ��ö�� M 74 170
102 �̿��� F 68 166
103 �ȼ��� F 55 155
104 �ڹ�ȣ M 72 167
105        M 66 169
106 ������ F 62   .
;
RUN;

PROC PRINT DATA=ex1_1;
RUN;

/*��跮�� ���*/
PROC MEANS DATA = ex1_1;
	VAR weight height; /*�����鿡 ���� ǥ���л� ����*/
RUN;

PROC UNIVARIATE DATA=ex1_1;
	VAR weight height;
RUN;
