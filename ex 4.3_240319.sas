DATA grade;
	INPUT id name $ class $ score grade $;
CARDS;
2590  john Stat  80.3  A
3569  wiley Math .     B
7048  younghee   . 30.6 C
9087 . Eng 100    A
. e.t .    .  .
;
RUN;
PROC PRINT DATA=grade;
RUN;
