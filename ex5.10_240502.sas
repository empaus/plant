DATA case;
	INPUT name $ x @@;
	RETAIN max_x 0 y 0 oldname '***';
	max_x =MAX(max_x,x);
	y=y+x*x;
	IF name=oldname THEN case='Old';
		ELSE case='New';
	oldname=name;
	DROP oldname;
CARDS;
AAA 1	BBB 4	BBB 8	BBB 3
CCC 2	CCC 5	DDD 6
;
RUN;
PROC PRINT;
RUN;


DATA case;
	INPUT name $ x @@;
/*	RETAIN max_x 0 y 0 oldname '***'; */
	max_x =MAX(max_x,x);
	y=y+x*x;
	IF name=oldname THEN case='Old';
		ELSE case='New';
	oldname=name;
/*	DROP oldname; */
CARDS;
AAA 1	BBB 4	BBB 8	BBB 3
CCC 2	CCC 5	DDD 6
;
RUN;
PROC PRINT;
RUN;


DATA case;
	INPUT name $ x @@;
/*	RETAIN max_x 0 y 0 oldname '***'; */
	max_x =MAX(max_x,x);
	y+x*x;
	IF name=oldname THEN case='Old';
		ELSE case='New';
	oldname=name;
/*	DROP oldname; */
CARDS;
AAA 1	BBB 4	BBB 8	BBB 3
CCC 2	CCC 5	DDD 6
;
RUN;
PROC PRINT;
RUN;
