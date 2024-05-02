DATA length;
	LENGTH name $ 9 grade $ 6;
	INPUT name $ score;
	If 1<=score<=3 then grade='LOW';
		ELSE IF 4<=score<=7 THEN grade='MIDDLE';
		ELSE IF 8<=score<=10 THEN grade='HIGH';
CARDS;
HyunCheol 7
YongChan 10
MinHee 3
;
RUN;
PROC PRINT;
RUN;
