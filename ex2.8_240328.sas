LIBNAME mysas 'D:\SAS24-1\SAS_Data'; /*�ܺζ��̺귯���� ����*/
DATA mysas.htwt;
	INFILE 'D:\SAS24-1\htwt.txt' FIRSTOBS=2;/*�ڷ��� �ι�° �ٺ��� ���� �ڷ������� firstobs �߰�*/
	INPUT name $ gender $dept $age height weight @@;/*���ٿ� ��ü�� ������ �� ���� �� @@ �߰�*/
RUN;
PROC PRINT;
RUN;
