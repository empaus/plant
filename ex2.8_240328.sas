LIBNAME mysas 'D:\SAS24-1\SAS_Data'; /*외부라이브러리에 저장*/
DATA mysas.htwt;
	INFILE 'D:\SAS24-1\htwt.txt' FIRSTOBS=2;/*자료의 두번째 줄부터 실제 자료임으로 firstobs 추가*/
	INPUT name $ gender $dept $age height weight @@;/*한줄에 개체가 여러개 들어가 있을 때 @@ 추가*/
RUN;
PROC PRINT;
RUN;
