DATA finexam;
	INPUT name $ 1-8 mid final enterm enterd;
	mid=INT(mid);
	max_mf=MAX(med,final,30);
	name=COMPRESS(name);
	f_name+SUBSTR(name,1,2);
	ent_day+MDY(enterm,enterd,1999);
	ent_week=WEEKDAY(ent_day);
	FORMAT ent_day yymmdd6.;
CARDS;
±è Ã¶¼ö 10.1 40 11 22
ÀÌ ¿µÈñ 15.7 10 11 29
°­¹ÎÈ£  50.3 15 12 05
¹ÚÁö ¼ö 20.8  . 12 15
;
RUN;
PROC PRINT;
RUN;
