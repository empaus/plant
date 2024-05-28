libname A "C:\Users\Park\Documents\park jiyul\university\4-1\캡스톤\edu_sample_db\교육용(SAS)";
libname t "C:\Users\Park\Documents\park jiyul\university\4-1\캡스톤\table";


PROC FREQ DATA=A.NSC2_EDU_G1E;
TABLE  Q_FHX_HTN Q_FHX_DM Q_NTR_PRF Q_DRK_FRQ_V0108 Q_DRK_AMT_V0108
Q_SMK_YN Q_PA_FRQ;
RUN;
/*기초통계량 확인-결측치*/
PROC FREQ DATA=A.NSC2_EDU_BNC;
TABLE SEX SIDO CTRB_Q10;
RUN;
/* 보험료 분위 568*/

PROC FREQ DATA=A.NSC2_EDU_BND;
TABLE BTH_YYYY;
RUN;

PROC FREQ DATA=A.NSC2_EDU_G1E;
TABLE EXMD_BZ_YYYY Q_FHX_HTN Q_FHX_DM Q_NTR_PRF Q_DRK_FRQ_V0108 Q_DRK_AMT_V0108
Q_SMK_YN Q_PA_FRQ G1E_BMI G1E_FBS G1E_TOT_CHOL Q_DRK_FRQ_V09N Q_DRK_AMT_V09N 
Q_PA_VD Q_PA_MD Q_PA_WALK;
RUN;
/*흡연: 56, 고혈압 가족력: 512, 당뇨 가족력: 526, 심장병 가족력: 537
영양 섭취 행태: 1455, 음주습관: 1451, 1회 음주량: 1974, 운동횟수 1459
BMI: 2, 식전혈당:X , 총 콜레스테롤:2, 주간 음주일수: 1095, 1회 음주량: 1653
격렬한 운동: 1094, 중간정도 운동: 1096, 걷기정도 운동: 1094
※ 1회 음주량, 주간 음주 일수, 운동의 경우 연도별 별수가 달랐기 때문으로 생각하여 연도별 결측치 확인
※ 영양 섭취 행태는 2006~2008년 자료에만 존재함으로 제외해야할 것 같음.
※ BMI는 키와 몸무게도 결측치여서 어쩔 수 없음.*/

DATA T.G1E_06_08;
SET A.NSC2_EDU_G1E;
IF EXMD_BZ_YYYY=2006 OR EXMD_BZ_YYYY=2008;
RUN;

PROC FREQ DATA=T.G1E_06_08;
TABLE Q_DRK_FRQ_V0108  Q_DRK_AMT_V0108 Q_PA_FRQ Q_PA_FRQ;
RUN;
/*음주습관: 47, 1회 음주량: 571 1주 운동횟수: 55*/

DATA T.DINRK;
SET T.G1E_06_08 (KEEP=Q_DRK_AMT_V0108 Q_DRK_FRQ_V0108);
IF Q_DRK_AMT_V0108= . ;
RUN;
/*1회 음주량이 결측치인 경우는 음주습관이 1이거나 결측치인 값이었음
-> 음주습관이 1인데 1회 음주량이 결측치인 경우는 1로 채워놓을 수 있을 것 같음.*/


DATA T.G1E_10_12;
SET A.NSC2_EDU_G1E;
IF EXMD_BZ_YYYY=2010 OR EXMD_BZ_YYYY=2012;
RUN;

PROC FREQ DATA=T.G1E_10_12;
TABLE Q_DRK_FRQ_V09N  Q_DRK_AMT_V09N Q_PA_VD Q_PA_MD Q_PA_WALK;
RUN;
/* 주간 음주 일수: 3, 1회 음주량: 561, 격렬한 운동: 2, 중간정도:4, 걷기:2 */

DATA T.DINRK2;
SET T.G1E_10_12 (KEEP=Q_DRK_FRQ_V09N Q_DRK_AMT_V09N);
IF Q_DRK_AMT_V09N= . ;
RUN;
/*1회 음주량이 결측치인 경우도 대부분이 주간 음주 일수가 0인 경우여서 채워 놓으면 좋을 것 같음.*/

/* 파일 합치기*/
DATA T.M20;
SET A.NSC2_EDU_M20(KEEP=RN_INDI SICK_SYM1 MDCARE_STRT_DT);
SICK_SYM = .;
IF (SUBSTR(SICK_SYM1,1,3) IN ("E10" ,"E11", "E12", "E13", "E14")) THEN SICK_SYM="1";
ELSE IF (SUBSTR(SICK_SYM1,1,3) IN ("I10","I11", "I12", "I13", "I14", "I15")) THEN SICK_SYM= "2";
ELSE IF ((SUBSTR(SICK_SYM1,1,3) = "E78")) THEN SICK_SYM="4";
ELSE SICK_SYM=0;
RUN;

PROC SQL;
CREATE TABLE T.M20_1 AS
SELECT DISTINCT RN_INDI, SUBSTR(MDCARE_STRT_DT,1,4) AS YEAR, SUM(DISTINCT(SICK_SYM)) AS SICK_SYM2
FROM T.M20
GROUP BY RN_INDI, YEAR
    ORDER BY RN_INDI, YEAR;
QUIT;
/* GROUP BY RN_INDI만 할지 YEAR도 같이할지 고민 */

PROC SQL;
CREATE TABLE T.BNC AS
SELECT RN_INDI, SEX, SIDO, CTRB_Q10
FROM  A.NSC2_EDU_BNC
GROUP BY RN_INDI;
QUIT;

PROC SQL;
CREATE TABLE T.JOIN AS
SELECT A.*, B.BTH_YYYY, C.SEX, C.SIDO, C.CTRB_Q10, C.STD_YYYY, D.SICK_SYM2
FROM A.NSC2_EDU_G1E AS A
LEFT JOIN A.NSC2_EDU_BND AS B ON A.RN_INDI=B.RN_INDI
LEFT JOIN A.NSC2_EDU_BNC AS C ON A.RN_INDI=C.RN_INDI AND A.EXMD_BZ_YYYY=C.STD_YYYY
LEFT JOIN T.M20_1 AS D ON A.RN_INDI=D.RN_INDI AND A.EXMD_BZ_YYYY=YEAR;
QUIT;
/* 문제점: CTRB_Q10과 SIDO가 자꾸 달라지다보니 RN_INDI로만 LEFT JOIN하면 데이터가 늘어남.
STD_YYYY(구축년도)와 EXMD_BZ_YYYY(검진년도) 사실 정의상 다르긴 한데, AND조건문으로 조건을 걸었을 때 A와 B LEFT JOIN과 수 같음.
-> 어떤 검진년도가 있을 때 구축이 늦게 되어 검진년도가 아닌데도 그렇게 적용되는 경우가 아니라면 EXMD_BZ_YYYY=STD_YYYY라고 볼 수 있지 않을까?
왜냐면 그 경우라면 다른 값은 결측이 될테니?
(EX. 검진년도 2008년인데, 2006년 데이터도 2008년에 구축되어 2008년에 결합되는 경우. 즉  RN_INDI인데 2008년 검진한게 2개가 되는 경우이면
2006년도에 검진한 것은 LEFTJOIN했는데, BNC데이터에는 없으니 결측이 될 것. 대신 2008년의 값은 2개가 될 것.)

PROC SORT DATA =T.JOIN OUT=AA NODUPKEY;
BY RN_INDI EXMD_BZ_YYYY;
RUN;
이 코드를 통해 RN_INDI와 EXMD_BZ_YYYY가 중복이 있는지 확인. 그니까 한 사람이 같은 년도에 건강검진 받은 기록이 있는지(LEFT JOIN에서 늘어나지 않았는지 확인)

DATA AAA;
SET T.JOIN;
IF STD_YYYY^=.;
RUN;
이 코드를 통해 STD_YYYY가 결합하다가 결측이 된 값 없는지 확인

이 정도면 ON에 A.EXMD_BZ_YYYY=C.STD_YYYY까지 조건 걸어도 된다고 생각하는데 어떤지?
이 방법이 안되면 MEAN(CTRB_Q10), 가장 빈도가 높은 지역으로 바꾸고 DISTINCT나 GROUP BY RN_INDI로 통일해서 분석해야할 것 같음. 
*/

/*MEAN(CTRB_Q10)은 반올림해줌. 범주같게 만들어야하기 때문*/
proc sql;
    create table T.SELECT_DATA as
    select RN_INDI, ROUND(mean(CTRB_Q10),1.) as mean_CTRB_Q10, CTRB_Q10, SIDO, SEX,  EXMD_BZ_YYYY,
Q_FHX_HTN, Q_FHX_DM, Q_DRK_FRQ_V0108, Q_DRK_AMT_V0108 ,Q_DRK_FRQ_V09N ,Q_DRK_AMT_V09N,
 Q_SMK_YN  ,Q_PA_FRQ ,G1E_BMI ,Q_PA_VD ,Q_PA_MD, Q_PA_WALK ,G1E_FBS ,G1E_TOT_CHOL,BTH_YYYY, SICK_SYM2
    from T.JOIN
    group by RN_INDI;
quit;

data T.FIX_MEAN;
    set T.SELECT_DATA;
    IF CTRB_Q10='.' THEN CTRB_Q10 = mean_CTRB_Q10; 
run;


DATA T.CATEGORI;
SET T.FIX_MEAN;
KEEP RN_INDI EXMD_BZ_YYYY SICK_SYM2 SICK_DM SICK_HTN SICK_HLD SICK_OX SEX AGE1 REGION INCOME DRINK BMI bloodsugar smoking 
Q_PA TOT_CHOL Q_FHX_HTN Q_FHX_DM ;
EXMD_YYYY = INPUT(EXMD_BZ_YYYY,4.);
YYYY=INPUT(BTH_YYYY,4.);
AGE=EXMD_YYYY-YYYY+1;
IF Q_SMK_YN='.' THEN DELETE;
IF G1E_BMI='.' THEN DELETE;
IF G1E_FBS='.' THEN DELETE;
IF G1E_TOT_CHOL='.' THEN DELETE;
IF CTRB_Q10='.' THEN DELETE;
IF (EXMD_BZ_YYYY="2010" OR EXMD_BZ_YYYY="2012") and Q_FHX_HTN=0 THEN Q_FHX_HTN=1;
ELSE IF (EXMD_BZ_YYYY="2010" OR EXMD_BZ_YYYY="2012") and Q_FHX_HTN=1 THEN Q_FHX_HTN=2;
ELSE IF Q_FHX_HTN='.' THEN Q_FHX_HTN=1;
IF (EXMD_BZ_YYYY="2010" OR EXMD_BZ_YYYY="2012") and Q_FHX_DM=0 THEN Q_FHX_DM=1;
ELSE IF (EXMD_BZ_YYYY="2010" OR EXMD_BZ_YYYY="2012") and Q_FHX_DM=1 THEN Q_FHX_DM=2;
ELSE IF Q_FHX_DM='.' THEN Q_FHX_DM=1;
/*나이*/
IF 0<=AGE<20 THEN AGE1="미포함";
   ELSE IF 20<=AGE<40 THEN AGE1='청년층';
   ELSE IF 40<=AGE<60 THEN AGE1='중장년충';
   ELSE IF 60<=AGE THEN AGE1='고령층';
/*흡연*/
IF Q_SMK_YN = 1 THEN smoking='1';
ELSE smoking='2';
/*식전혈당*/
IF G1E_FBS <= 99 THEN bloodsugar = '1(good)';
ELSE IF G1E_FBS >= 125 THEN bloodsugar = '3(bad)';
ELSE bloodsugar = '2(bad)';
/*음주*/
IF Q_DRK_FRQ_V0108>1 OR Q_DRK_AMT_V0108>1 THEN DRINK='1';
	ELSE IF 0<=Q_DRK_FRQ_V0108<=1 OR 0<=Q_DRK_AMT_V0108<=1 THEN DRINK='0';
IF Q_DRK_FRQ_V09N>=2 OR Q_DRK_AMT_V09N>=3 THEN DRINK='1';
	ELSE IF 0<=Q_DRK_FRQ_V09N<2 OR 0<Q_DRK_AMT_V09N<3 THEN DRINK='0';
/*BMI*/
IF G1E_BMI<18.5 THEN BMI='저체중';
	ELSE IF G1E_BMI<23 THEN BMI='정상';
		ELSE IF G1E_BMI<25 THEN BMI='과체중';
			ELSE IF G1E_BMI<30 THEN BMI='비만';
ELSE BMI='고도비만';
/*운동*/
IF (EXMD_BZ_YYYY="2006" OR EXMD_BZ_YYYY="2008") AND (Q_PA_FRQ=1 OR Q_PA_FRQ=2) THEN Q_PA=1;
	ELSE IF (EXMD_BZ_YYYY="2006" OR EXMD_BZ_YYYY="2008") AND 
				(Q_PA_FRQ=3 OR Q_PA_FRQ=4 OR Q_PA_FRQ=5) THEN Q_PA=2;
				ELSE IF (EXMD_BZ_YYYY="2010" OR EXMD_BZ_YYYY="2012") AND (0<Q_PA_VD+Q_PA_MD+Q_PA_WALK<3) THEN Q_PA=1;
					ELSE IF (EXMD_BZ_YYYY="2010" OR EXMD_BZ_YYYY="2012") AND (Q_PA_VD+Q_PA_MD+Q_PA_WALK>=3) THEN Q_PA=2;
						ELSE Q_PA=0;
/*콜레스테롤*/
IF G1E_TOT_CHOL<200 THEN TOT_CHOL=0;
ELSE IF 200<=G1E_TOT_CHOL<240 THEN TOT_CHOL=1;
ELSE TOT_CHOL=2;
/*주상병*/
IF SICK_SYM2='.' THEN SICK_SYM2=0;
IF SICK_SYM2 = 1 OR SICK_SYM2 = 3 OR SICK_SYM2 = 5 OR SICK_SYM2 = 7 THEN SICK_DM = "당뇨";
ELSE SICK_DM="X";
IF SICK_SYM2 = 2 OR SICK_SYM2 = 3 OR SICK_SYM2 = 6 OR SICK_SYM2 = 7 THEN SICK_HTN = "고혈압";
ELSE SICK_HTN="X";
IF SICK_SYM2 = 4 OR SICK_SYM2 = 5 OR SICK_SYM2 = 6 OR SICK_SYM2 = 7 THEN SICK_HLD = "고지혈증";
ELSE SICK_HLD="X";
IF SICK_SYM2>=1 THEN SICK_OX=1;
ELSE SICK_OX=0;
/*지역*/
IF SIDO="11" THEN REGION="서울";
ELSE REGION= "비수도권";
/*소득분위*/
IF CTRB_Q10 <=4 THEN INCOME = '하';
ELSE IF CTRB_Q10 >=9 THEN INCOME = '상';
ELSE INCOME = '중';
RUN;


DATA T.ANAL_DATA;
SET T.CATEGORI;
RETAIN RN_INDI EXMD_BZ_YYYY SEX AGE1 SICK_SYM2 REGION INCOME DRINK BMI BLOODSUGAR SMOKING Q_PA TOT_CHOL 
Q_FHX_HTN Q_FHX_DM SICK_DM SICK_HTN SICK_HLD SICK_OX;
RUN;


/* 전처리 후 분석*/
proc freq data=T.ANAL_DATA;
    tables SICK_SYM2;
RUN;
/*질병 O와 X는 7:3비율 정도 됨.*/

/*질병 유무에 따른 기초통계량*/
%macro frequency(sick, variable);
proc sort data=T.ANAL_DATA;
    by &sick; 
run;

proc freq data=T.ANAL_DATA ;
	BY &sick;
    tables &variable;
RUN; 
%mend;
%frequency(SICK_DM,SEX AGE1 SICK_SYM2 REGION INCOME DRINK BMI bloodsugar smoking Q_PA TOT_CHOL 
Q_FHX_HTN Q_FHX_DM);
%frequency(SICK_HTN,SEX AGE1 SICK_SYM2 REGION INCOME DRINK BMI bloodsugar smoking Q_PA TOT_CHOL 
Q_FHX_HTN Q_FHX_DM);
%frequency(SICK_HLD,SEX AGE1 SICK_SYM2 REGION INCOME DRINK BMI bloodsugar smoking Q_PA TOT_CHOL 
Q_FHX_HTN Q_FHX_DM);
%frequency(SICK_OX,SEX AGE1 SICK_SYM2 REGION INCOME DRINK BMI bloodsugar smoking Q_PA TOT_CHOL 
Q_FHX_HTN Q_FHX_DM );

/*ttest*/
/*ttest는 원데이터로 봐야할 것 같음 연속형이기 때문.*/
/*%macro ttest(sick,variable);*/
/*proc ttest data=T.ANAL_DATA;*/
/*class &sick;*/
/*var &variable;*/
/*run;*/
/*%mend;*/
/*%ttest(SICK_DM, variable);*/

/*카이제곱 검정*/
%macro chi(sick,variable);
proc freq data=T.ANAL_DATA;
table (&variable)*&sick/chisq nocol nopercent;
run;
%mend;
%chi(sick_dm, SEX AGE1 SICK_SYM2 REGION INCOME DRINK BMI bloodsugar smoking Q_PA TOT_CHOL 
Q_FHX_HTN Q_FHX_DM );
%chi(sick_htn, SEX AGE1 SICK_SYM2 REGION INCOME DRINK BMI bloodsugar smoking Q_PA TOT_CHOL 
Q_FHX_HTN Q_FHX_DM );
%chi(sick_hld, SEX AGE1 SICK_SYM2 REGION INCOME DRINK BMI bloodsugar smoking Q_PA TOT_CHOL 
Q_FHX_HTN Q_FHX_DM );
%chi(sick_OX, SEX AGE1 SICK_SYM2 REGION INCOME DRINK BMI bloodsugar smoking Q_PA TOT_CHOL 
Q_FHX_HTN Q_FHX_DM );

/*단순 로지스틱 회귀분석*/
/*%macro logistic(var,standard,sick, sick_index);*/
/*proc logistic data=T.ANAL_DATA;*/
/*   class &var(ref=&standard);*/
/*    model &sick(event=&sick_index)= &var;*/
/*run;*/
/*%mend;*/
/*당뇨*/
%macro logistic(var,standard);
proc logistic data=T.ANAL_DATA;
   class &var(ref=&standard);
    model sick_dm(event="당뇨")= &var;
run;
%mend;
%logistic(BMI, '정상' );
%logistic(INCOME,"중");

%macro logistic(var,standard);
proc logistic data=T.ANAL_DATA;
   class &var(ref=&standard);
    model sick_htn(event="고혈압")= &var;
run;
%mend;




/*다중 로지스틱 오즈비 분석*/
%macro multi(sick,sick_index);
proc logistic data=T.ANAL_DATA;
class sex(ref='1') REGION(ref='서울') AGE1(ref='청년층') BMI(ref='정상') TOT_CHOL(ref='1') Q_FHX_HTN(ref='1') Q_FHX_DM(ref='1')
			DRINK(ref='0') smoking(ref='1') Q_PA(ref='1') INCOME(ref='중') BLOODSUGAR(ref="1(good)");
model &sick(event=&sick_index) = sex REGION AGE1 BMI TOT_CHOL Q_FHX_HTN Q_FHX_DM DRINK smoking Q_PA INCOME BLOODSUGAR;
run;
%mend;

%multi(sick_dm, "당뇨");
%multi(sick_htn, "고혈압");
%multi(sick_HLD, "고지혈증");
%multi(sick_OX, "1");

/*다중 로지스틱 회귀분석 정확도*/
%MACRO MULTI_LOG(SICK, SICK_INDEX);
proc logistic data=T.ANAL_DATA;
class sex(ref='1') REGION(ref='서울') AGE1(ref='청년층') BMI(ref='정상') TOT_CHOL(ref='1') Q_FHX_HTN(ref='1') Q_FHX_DM(ref='1') 
			DRINK(ref='0') smoking(ref='1') Q_PA(ref='1') INCOME(ref='중') BLOODSUGAR(ref="1(good)");
model &SICK(event=&sick_index) = sex REGION AGE1 BMI TOT_CHOL Q_FHX_HTN Q_FHX_DM DRINK smoking Q_PA INCOME BLOODSUGAR/
SELECTION=FORWARD
CTABLE PPROB = (0 TO 1 BY .1)
LACKFIT
RISKLIMITS;
ROC;
run;
%MEND;

%MULTI_LOG(SICK_OX, "1");
%MULTI_LOG(SICK_DM,"당뇨");
%MULTI_LOG(SICK_HTN,"고혈압");
%MULTI_LOG(SICK_HLD,"고지혈증");
