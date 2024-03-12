DATA company;
	INFILE 'D:\SAS 24-1\기업이미지.txt';
	INPUT id 1-2 age 3 gender $ 4 item1 5 item2 6 item3 7;
	LABEL id='고객번호' age='나이' gender='성별'
		  item1='좋은 제품을 만들기 위해 노력한다'
		  item2='소비자를 중요하게 여긴다'
		  item3='신뢰할만한 기업이다';
RUN;

PROC MEANS DATA=company;
	VAR item1 item2 item3;
RUN;
