DATA company;
	INFILE 'D:\SAS 24-1\����̹���.txt';
	INPUT id 1-2 age 3 gender $ 4 item1 5 item2 6 item3 7;
	LABEL id='����ȣ' age='����' gender='����'
		  item1='���� ��ǰ�� ����� ���� ����Ѵ�'
		  item2='�Һ��ڸ� �߿��ϰ� �����'
		  item3='�ŷ��Ҹ��� ����̴�';
RUN;

PROC MEANS DATA=company;
	VAR item1 item2 item3;
RUN;
