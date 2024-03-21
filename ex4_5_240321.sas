DATA dept;
	INPUT name $18. +1 hired DATE7. +1 salary 5.;
	FORMAT hired DATE7.;
CARDS;
Martin. Virginia   09aug80 34800
Singleton. MaryAnn 24apr85 27900
Leighton.Maurice   16dec83 32600
Freuler. Carl      15feb88 29900
Cage. Merce        19oct82 39800
;
RUN;
PROC PRINT;
RUN;
