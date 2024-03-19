/*연습문제 2-2, 6, 7*/
LIBNAME Mysas 'D:\SAS 24-1\SAS_Data';

DATA mysas.drink;
	INFILE 'D:\SAS 24-1\음료수.txt';
	INPUT age drink count;
RUN;

DATA customer;
INFILE 'D:\SAS 24-1\customer.txt';
INPUT obs city $ name $ age;
RUN;

LIBNAME ex 'D:\SAS 24-1\example';
DATA ex.customer;
	INFILE 'D:\SAS 24-1\SAS_Data\customer.txt';
	INPUT obs city  $ name $ age;
RUN;
