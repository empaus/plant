DATA avescore;
	INPUT name $ (x1-x3)(1.)y1-y3;
	total=SUM(OF x1-x3 y1-y3);
	average=MEAN(OF x1-x3 y1-y3);
	average2=(x1+x2+x3+y1+y2+y3)/6;
	average3=SUM(x1,x2,x3,y1,y2,y3)/6;
CARDS;
��ö�� 551 2 1 3
�ֹ��� .31 4 5 1
�̿��� 153 2 . 2
���μ� 412 4 . .
;
RUN;
PROC PRINT;
RUN;
