DATA club;
	INPUT idno name $ 6-19 @25 team $6. strtwght endwght;
CARDS;
1023 David Shaw		
red    
189 165
1049 Amelia Serrano 
yellow 
189 165
;
RUN;
PROC PRINT;
RUN;
