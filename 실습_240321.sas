DATA person;
	INFILE "C:\SAS 23-1\성적.txt" ENCODING="UTF-8";
	INPUT name $ dept $ salary age;
RUN;


DATA grade;
		INPUT id name $ class $score grade $;
CARDS;
2590	john Stat 80.3 A
3569 willy Math . B
7048 yonghee . 30.3 C
9087 . Eng 100 A
. e.t . . .
;
RUN;
PROC PRINT;
RUN;
문자형 자료가 존재하는 부분의 공백에는 . 입력 


