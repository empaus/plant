LIBNAME Mysas 'D:\SAS 24-1\SAS_Data';

DATA mysas.htwt;
	INPUT name $ gender $ dept $ age height weight;
	LABEL name='�̸�' gender='����';
CARDS;
��ö�� M Stat 25 170 67
����ȣ M Stat 20 169 70
�̿��� F Math 19 160 58
������ F Econ 21 160 59
�ָ�ȣ M Math 28 177 62
;
RUN;

PROC PRINT DATA=mysas.htwt;
RUN;
