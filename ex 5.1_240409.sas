DATA exam;
	INPUT id $ name $ mid final;
CARDS;
001 ��ö�� 10 40
002 �̿��� 15 10
001 ����ȣ 50 15
001 ������ 20 . 
;
RUN;
PROC PRINT;
RUN;

DATA exam1;
	SET exam;
	x=30;
	major='�����';
	major_id='STA'||id;    
	mean=(mid+final)/2;
	y=mid**3;
	LABEL name='�̸�' mid='�߰�����' final='�⸻����';
RUN;
PROC PRINT;
RUN;
