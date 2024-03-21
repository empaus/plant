DATA jansales;
	INPUT item $10. (jan feb mar) (+5 COMMA5.) (score1-score3) (4.1);
CARDS;
trucks	     1.382 	  2.789	  3.556 121 114 137
jeeps	     1.235	  2.543	  3.987 111 97  122
landrovers   2.391    3.011   3.658 156 142 143
;
RUN;
PROC PRINT;
RUN; 
