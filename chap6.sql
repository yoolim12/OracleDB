-- 실습에 필요한 테이블 생
CREATE TABLE DEPT_YOOLIM
(
DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13)
);
CREATE TABLE EMP_YOOLIM
(
EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7,2),
COMM NUMBER(7,2),
DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT_YOOLIM
);
INSERT INTO DEPT_YOOLIM VALUES
(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT_YOOLIM VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT_YOOLIM VALUES
(30,'SALES','CHICAGO');
INSERT INTO DEPT_YOOLIM VALUES
(40,'OPERATIONS','BOSTON');
INSERT INTO EMP_YOOLIM VALUES
(7369,'SMITH','CLERK',7902,to_date('1980-12-17','YYYY-MM-DD'),800,NULL,20);
INSERT INTO EMP_YOOLIM VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('1981-2-20','YYYY-MM-DD'),1600,300,30);
INSERT INTO EMP_YOOLIM VALUES
(7521,'WARD','SALESMAN',7698,to_date('1981-2-22','YYYY-MM-DD'),1250,500,30);
INSERT INTO EMP_YOOLIM VALUES
(7566,'JONES','MANAGER',7839,to_date('1981-4-2','YYYY-MM-DD'),2975,NULL,20);
INSERT INTO EMP_YOOLIM VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('1981-9-28','YYYY-MM-DD'),1250,1400,30);
INSERT INTO EMP_YOOLIM VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1981-5-1','YYYY-MM-DD'),2850,NULL,30);
INSERT INTO EMP_YOOLIM VALUES
(7782,'CLARK','MANAGER',7839,to_date('1981-6-9','YYYY-MM-DD'),2450,NULL,10);
INSERT INTO EMP_YOOLIM VALUES
(7788,'SCOTT','ANALYST',7566,to_date('1987-7-13','YYYY-MM-DD')-85,3000,NULL,20);
INSERT INTO EMP_YOOLIM VALUES
(7839,'KING','PRESIDENT',NULL,to_date('1981-11-17','YYYY-MM-DD'),5000,NULL,10);
INSERT INTO EMP_YOOLIM VALUES
(7844,'TURNER','SALESMAN',7698,to_date('1981-9-8','YYYY-MM-DD'),1500,0,30);
INSERT INTO EMP_YOOLIM VALUES
(7876,'ADAMS','CLERK',7788,to_date('1987-7-13','YYYY-MM-DD')-51,1100,NULL,20);
INSERT INTO EMP_YOOLIM VALUES
(7900,'JAMES','CLERK',7698,to_date('1981-12-3','YYYY-MM-DD'),950,NULL,30);
INSERT INTO EMP_YOOLIM VALUES
(7902,'FORD','ANALYST',7566,to_date('1981-12-3','YYYY-MM-DD'),3000,NULL,20);
INSERT INTO EMP_YOOLIM VALUES
(7934,'MILLER','CLERK',7782,to_date('1982-1-23','YYYY-MM-DD'),1300,NULL,10);
CREATE TABLE BONUS_YOOLIM
(
ENAME VARCHAR2(10) ,
JOB VARCHAR2(9) ,
SAL NUMBER,
COMM NUMBER
) ;
CREATE TABLE SALGRADE_YOOLIM
( GRADE NUMBER,
LOSAL NUMBER,
HISAL NUMBER );
INSERT INTO SALGRADE_YOOLIM VALUES (1,700,1200);
INSERT INTO SALGRADE_YOOLIM VALUES (2,1201,1400);
INSERT INTO SALGRADE_YOOLIM VALUES (3,1401,2000);
INSERT INTO SALGRADE_YOOLIM VALUES (4,2001,3000);
INSERT INTO SALGRADE_YOOLIM VALUES (5,3001,9999);
COMMIT;


-- EMP_YOOLIM 테이블 구성 보기
DESC EMP_YOOLIM;

-- SQL문의 출력 결과로 SELECT절에 명시한 열 중에서 같은 내용이 2개 이상일 경우, 중복 행은 1개만 남겨 두고 그 밖의 행은 모두 제거
SELECT DISTINCT DEPTNO FROM EMP_YOOLIM;

-- 여러 컬럼을 동시에 나열하여 사용하는 것도 가능한데, 이 경우 나열된 컬럼을 한 묶음으로 보고 이 두 정보를 묶은 전체 내용과 일치하는 레코드들의 중복이 제거되는 것이다.
-- 즉 JOB은 같지만 DEPTNO가 다른 경우 중복 제거 대상에 포함되지 않는다.
SELECT DISTINCT JOB, DEPTNO FROM EMP_YOOLIM;

-- ALL은 DISTINCT와 반대로 데이터 중복을 제거하지 않고 그대로 출력. SELECT JOB, DEPTNO FROM EMP_YOOLIM 과 같은 결과가 나오므로 생략해도 무관.
SELECT ALL JOB, DEPTNO FROM EMP_YOOLIM;

-- ENAME 열 값의 첫 문자와 대문자 F를 비교했을 때 알파벳 순서상 F와 같거나 F보다 뒤에 있는 문자열 출력
-- 여기서 이상한건 SELECT * FROM EMP_YOOLIM WHERE ENAME > 'F'을 해도 첫 문자가 'F'인 것들을 포함한 것들까지 함께 출력된다. 등호가 별 의미 없는듯..?
SELECT * FROM EMP_YOOLIM WHERE ENAME >= 'F';

-- 이렇게 했을 때 ENAME 열 값의 첫 문자와 대문자 F를 비교했을 때 알파벳 순서상 F와 같거나 F보다 앞에 있는 문자열이 출력될줄 알았는데, 첫 문자가 'F'인 것들은 출력 안되고 F보다 앞에 있는 문자열들만 출력된다.
-- 진짜 등호가 큰 의미 없는듯 하다... >(또는 >=)이면 등호 포함이고, <(또는 <=)이면 등호 제외고.
SELECT * FROM EMP_YOOLIM WHERE ENAME <= 'F';

-- ENAME 열 값이 FORZ를 포함한 문자열보다 알파벳 순서로 앞에 있는 행을 출력(영어사전을 본다고 했을 때 FORZ보다 앞에 있을 문자열들 출력)
SELECT * FROM EMP_YOOLIM WHERE ENAME <= 'FORZ';

-- 아래 3개의 SQL문들은 모두 같은 결과를 출력
SELECT * FROM EMP_YOOLIM WHERE SAL != 3000;
SELECT * FROM EMP_YOOLIM WHERE SAL <> 3000;
SELECT * FROM EMP_YOOLIM WHERE SAL ^= 3000;

-- 논리 부정 연산자(WHERE절이 TRUE가 아닌 것들 출력)
SELECT * FROM EMP_YOOLIM WHERE NOT SAL = 3000;

-- 아래 2개의 SQL문도 같은 결과를 출력
SELECT * FROM EMP_YOOLIM WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' OR JOB = 'CLERK';
SELECT * FROM EMP_YOOLIM WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- 아래 2개의 SQL문도 같은 결과를 출력
SELECT * FROM EMP_YOOLIM WHERE JOB != 'MANAGER' AND JOB != 'SALESMAN' AND JOB != 'CLERK';
SELECT * FROM EMP_YOOLIM WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- 아래 2개의 SQL문도 같은 결과를 출력(2000 이상 3000 이하)
SELECT * FROM EMP_YOOLIM WHERE SAL >= 2000 AND SAL <= 3000;
SELECT * FROM EMP_YOOLIM WHERE SAL BETWEEN 2000 AND 3000;

-- 이때 아무 데이터도 출력되지 않는 것을 볼 수 있다.
-- NULL은 산술 연산자와 비교 연산자로 비교해도 결과값이 NULL이 나오기 때문이다.(NULL + 100 = NULL, NULL - 100 = NULL)
-- WHERE절은 조건식의 결과값이 TRUE인 행만 출력하는데 이처럼 연산 결과 값이 NULL이 되어 버리면 조건식의 결과값이 FALSE도 TRUE도 아니게 되므로 출력 대상에서 제외된다.
SELECT * FROM EMP_YOOLIM WHERE COMM = NULL;

-- 컬럼 COMM이 NULL인 것들을 출력하기 위해서는 아래와 같이 작성해야한다.
SELECT * FROM EMP_YOOLIM WHERE COMM IS NULL;

-- SQL문에서는 SELECT문을 통해 데이터를 조회한 결과를 하나의 집합과 같이 다룰 수 있는 집합 연산자를 사용할 수 있다.
-- 그리고 2개 이상의 SELECT문의 결과 값을 연결할 때 사용한다.
-- 여기서 주의할 점은 집합 연산자로 2개의 SELECT문의 결과 값을 연결할 때 각 SELECT문이 출력하려는 열 개수와 각 열의 자료형이 순서별로 일치해야한다는 점이다.
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 20;

-- SELECT문이 출력하려는 열 개수가 달라서 에러
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL
FROM EMP_YOOLIM
WHERE DEPTNO = 20;

-- SELECT문이 출력하려는 각 열의 자료형이 순서별로 일치하지 않아서 에러
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 10
UNION
SELECT ENAME, EMPNO, DEPTNO, SAL
FROM EMP_YOOLIM
WHERE DEPTNO = 20;

-- 연결하려는 두 SELECT문의 열 개수와 자료형이 같다면 서로 다른 테이블에서 조회하거나 조회하는 열 이름이 다른 것은 문제가 되지 않는다.
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 10
UNION
SELECT SAL, JOB, DEPTNO, SAL
FROM EMP_YOOLIM
WHERE DEPTNO = 20;


--오라클 데이터베이스에서 사용되는 집합 연산자는 다음과 같이 4가지 종류가 있다.
--
--1. UNION
--연결된 SELECT문의 결과 값을 합집합으로 묶어준다. 결과 값의 중복은 제거된다.
--
--2. UNION ALL
--연결된 SELECT문의 결과 값을 합집합으로 묶어준다. 결과 값의 중복은 제거되지 않는다는 점이 UNION과의 차이점이다.
--
--3. MINUS
--먼저 작성한 SELECT문의 결과값에서 다음 SELECT문의 결과 값을 차집합 처리한 것이다. 먼저 작성한 SELECT문의 결과 값 중 다음 SELECT문에 존재하지 않는 데이터만 출력된다.
--
--4. INTERSECT
--먼저 작성한 SELECT문의 결과값과 다음 SELECT문의 결과 값이 같은 데이터만 출력된다. 교집합과 같은 의미이다.
-- 중복이 제거되어 나옴


SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 10;

-- 중복이 제거되지 않고 나옴
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 10;

--차집합
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 10
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE ENAME LIKE '%I%';

--교집합
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE DEPTNO = 10
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_YOOLIM
WHERE ENAME LIKE '%I%';

-- INITCAP은 맨 첫 알파벳만 대문자로
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP_YOOLIM;
SELECT ENAME
FROM EMP_YOOLIM
WHERE UPPER(ENAME) = UPPER('scott');

SELECT ENAME
FROM EMP_YOOLIM
WHERE UPPER(ENAME) LIKE UPPER('%scott%');
SELECT ENAME, LENGTH(ENAME)
FROM EMP_YOOLIM;


-- LENGTHB 함수는 문자열 데이터 길이가 아닌 바이트 수를 반환
SELECT LENGTH('한글'), LENGTHB('한글')
FROM DUAL;

-- SUBSTR(문자열 데이터, 시작 위치, 추출 길이) : 문자열 데이터의 시작 위치부터 추출 길이만큼 추출한다. 추출 길이를 지정해주지 않은 경우 지정한 시작 위치부터 끝까지 추출한다.
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
FROM EMP_YOOLIM;

-- 시작 위치에 음수가 들어간 경우 뒤에서부터 세면 된다. 예를 들어, SUBSTR(JOB, -3)는 뒤에서부터 3번째
SELECT JOB, SUBSTR(JOB, -LENGTH(JOB)), SUBSTR(JOB, -LENGTH(JOB), 2), SUBSTR(JOB, -3) FROM EMP_YOOLIM;


-- 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지를 알고자 할때 INSTR 함수를 사용한다.
--INSTR(
--[대상 문자열 데이터(필수)],
--[위치를 찾으려는 부분 문자(필수)],
--[위치 찾기를 시작할 대상 문자열 데이터 위치(선택, 기본값은 1),
--[시작 위치에서 찾으려는 문자가 몇 번째인지 지정(선택, 기본값은 1)]
--)
--INSTR('HELLO, ORACLE!', 'L') : 처음부터 검색해서 가장 먼저 'L'이 나오는 위치 출력 -> 3
--INSTR('HELLO, ORACLE!', 'O', 5) : 다섯번째 글자인 'O'부터 탐색해서 가장 먼저 'O'가 나오는 위치 출력 -> 5
--INSTR('HELLO, ORACLE!', 'L', 2, 2) : 두번째 글자인 'E'부터 탐색해서 두번째 'L'이 나오는 위치 출력

SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1,
INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,
INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3
FROM DUAL;


-- 이런 식으로도 ENAME에 'S'가 들어가는 행을 구할 수 있다.
--SELECT *
--FROM EMP_YOOLIM
--WHERE ENAME LIKE '%S%';
--와 같다.
SELECT *
FROM EMP_YOOLIM
WHERE INSTR(ENAME,'S') > 0;


-- REPLACE([문자열 데이터 또는 열 이름(필수)], [찾는 문자(필수)], [대체할 문자(선택)])
--대체할 문자열을 입력하지 않는다면 찾는 문자로 지정한 문자는 문자열 데이터에서 삭제된다.
--REPLACE('010-1234-5678','-') 결과값이 REPLACE('010-1234-5678','-','')와 같다.
SELECT '010-1234-5678' AS REPLACE_BEFORE,
REPLACE('010-1234-5678','-',' ') AS REPLACE_1,
REPLACE('010-1234-5678','-') AS REPLACE_2
FROM DUAL;


--LPAD와 RPAD는 각각 Left Padding(왼쪽 패딩), Right Padding(오른쪽 패딩)을 뜻한다.
--데이터와 자릿수를 지정한 후 데이터 길이가 지정한 자릿수보다 작을 경우 나머지 공간을 특정 문자로 채우는 함수이다.
--LPAD는 남은 빈 공간을 왼쪽에 채우고, RPAD는 오른쪽에 채운다.
--만약에 빈 공간에 채울 문자를 지정하지 않으면 LPAD와 RPAD 함수는 빈 공간의 자릿수만큼 공백 문자로 채운다.
--
--LPAD([문자열 데이터 또는 열이름(필수)], [데이터의 자릿수(필수)], [빈 공간에 채울 문자(선택)])
--RPAD([문자열 데이터 또는 열이름(필수)], [데이터의 자릿수(필수)], [빈 공간에 채울 문자(선택)])

SELECT 'ORACLE' AS BEFORE_PAD,
LPAD('ORACLE', 10, '#') AS LPAD_1,
RPAD('ORACLE', 10, '*') AS RPAD_1,
LPAD('ORACLE', 10) AS LPAD_2,
RPAD('ORACLE', 10) AS RPAD_2
FROM DUAL;


--(유림's test)데이터 길이가 지정한 자릿수보다 클 경우 LPAD, RPAD 모두 앞에서부터 지정된 자릿수까지의 문자만 출력한다.
--아래의 예를 들자면 LPAD('Oracle', 3, '#'), RPAD('Oracle', 3, '#') 모두 'Ora'를 출력한다.
SELECT LPAD('Oracle', 3, '#') AS LPAD_1, RPAD('Oracle', 3, '#') AS RPAD_1
FROM DUAL;
SELECT RPAD('980212-', 14, '*') AS R1, RPAD('010-1234-', 13, '*') AS R2
FROM DUAL;


--CONCAT 함수는 2개의 문자열 데이터를 하나로 연결해주는 역할을 한다.
--2개의 입력 데이터를 지정하고 열이나 문자열 데이터 모두 지정할 수 있다.
SELECT CONCAT(EMPNO, ENAME),
CONCAT(EMPNO, CONCAT(' : ', ENAME))
FROM EMP_YOOLIM;
WHERE ENAME = 'SCOTT';

--|| 연산자는 CONCAT 함수와 유사하게 열이나 문자열을 연결한다.
SELECT EMPNO || ENAME,
EMPNO || ' : ' || ENAME
FROM EMP_YOOLIM
WHERE ENAME='SCOTT';


--TRIM, LTRIM, RTRIM 함수는 문자열 데이터 내에서 특정 문자를 지우기 위해 사용된다.
--1. TRIM
--삭제할 문자 지정이 생략되었을 경우 기본적으로 공백을 제거한다.
--삭제 옵션은 왼쪽에 있는 글자를 지우는 LEADING, 오른쪽에 있는 글자를 지우는 TRAILING, 양쪽의 글자를 모두 지우는 BOTH를 사용한다.
--(삭제 옵션 지정이 생략되었을 경우 기본적으로 BOTH를 적용한다.)
--아래와 같은 경우 양쪽에서 '_'를 지운 결과를 출력한다.
--아래의 경우 양쪽이 '_'가 아닌 공백으로 시작하므로 아무 것도 지우지 않은 채 출력이 된다.
SELECT '[' || TRIM('_' FROM ' _ _ ORACLE _ _ ') || ']' AS TRIM FROM DUAL;


--아래와 같은 경우 양쪽에서 공백을 지운 결과를 출력한다.
--아래의 경우 양쪽이 공백으로 시작하므로 공백이 나오지 않을 때까지 양쪽 공백을 지우고 '_'가 나오는 부분에서 지우는 것을 멈춘 채로 출력이 된다.
SELECT '[' || TRIM(' _ _ ORACLE _ _ ') || ']' AS TRIM FROM DUAL;


-- 이렇게 하면 에러가 난다. TRIM 설정은 'H', '_'와 같이 하나 문자만 가지고 있어야 하기 때문이다.
SELECT '[' || TRIM('HELLO' FROM 'HELLO_ORACLE_HELLO') AS TRIM FROM DUAL;
SELECT '[' || TRIM('_' FROM '_ _ORACLE_ _') || ']' AS TRIM,
'[' || TRIM(LEADING '_' FROM '_ _ORACLE_ _') || ']' AS TRIM_LEADING,
'[' || TRIM(TRAILING '_' FROM '_ _ORACLE_ _') || ']' AS TRIM_TRAILING,
'[' || TRIM(BOTH '_' FROM '_ _ORACLE_ _') || ']' AS TRIM_BOTH
FROM DUAL;


--2. LTRIM, RTRIM
--LTRIM, RTRIM 함수는 각각 왼쪽, 오른쪽의 지정 문자를 삭제하는 데 사용한다.
--TRIM과 마찬가지로 삭제할 문자를 지정하지 않을 경우 공백 문자가 삭제된다.
--TRIM 함수와 다른 점은 삭제할 문자를 하나만 지정하는 것이 아니라 여러 문자 지정이 가능하다는 것이다.
--(따라서 LTRIM과 TRIM에서의 LEADING은 지정할 수 있는 문자의 개수가 다르므로 서로 다른 것이다!! 마찬가지로 RTRIM과 TRAILING도 서로 다르다!)
--LTRIM([원본 문자열 데이터(필수)], [삭제할 문자 집합(선택)])
--RTRIM([원본 문자열 데이터(필수)], [삭제할 문자 집합(선택)])
SELECT '[' || TRIM(' _ORACLE_ ') || ']' AS TRIM,
'[' || LTRIM(' _ORACLE_ ') || ']' AS LTRIM,
'[' || LTRIM('<_ORACLE_>', '_<') || ']' AS LTRIM_2, -- '<_ORACLE_>' 문자열의 왼쪽에서 '_' 또는 '<'에 해당하는 문자가 있을 경우 '_','<'에 해당하지 않는 문자가 나올 때까지 삭제한다.
'[' || RTRIM(' _ORACLE_ ') || ']' AS RTRIM,
'[' || RTRIM('<_ORACLE_>', '>_') || ']' AS RTRIM_2
FROM DUAL;


--ROUND 함수는 특정 숫자를 반올림하는 함수로, 반올림할 위치를 지정할 수 있다.
--반올림할 위치를 지정하지 않으면 기본적으로 0으로 설정해서 소수점 첫째 자리에서 반올림한 결과가 반환된다.
--ROUND([숫자(필수)], [반올림 위치(선택)])
--n이 0 또는 양수라고 할때,
--ROUND(숫자, n): 소수점 n+1 자리에서 반올림
--ROUND(숫자, -n(음수일때)) : 자연수 부분에서 n자리에서 반올림
SELECT ROUND(1234.5678) AS ROUND,
ROUND(1234.5678, 0) AS ROUND_0,
ROUND(1234.5678, 1) AS ROUND_1,
ROUND(1234.5678, 2) AS ROUND_2,
ROUND(1234.5678, -1) AS ROUND_MINUS1,
ROUND(1234.5678, -2) AS ROUND_MINUS2
FROM DUAL;


--TRUNC 함수는 지정된 자리에서 숫자를 버림 처리하는 함수이다.
--TRUNC 함수 역시 반올림 위치를 지정하지 않으면 소수점 첫째자리에서 버림 처리된다.
--ROUND 함수와 마찬가지로, TRUNC 함수 또한
--n이 0 또는 양수라고 할때,
--TRUNC(숫자, n): 소수점 n+1 자리에서 버림
--TRUNC(숫자, -n(음수일때)) : 자연수 부분에서 n자리에서 버림
SELECT TRUNC(1234.5678) AS TRUNC,
TRUNC(1234.5678, 0) AS TRUNC_0,
TRUNC(1234.5678, 1) AS TRUNC_1,
TRUNC(1234.5678, 2) AS TRUNC_2,
TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
TRUNC(1234.5678, -2) AS TRUNC_MINUS2
FROM DUAL;


--CEIL 함수와 FLOOR 함수는 각각 입력된 숫자와 가장 가까운 큰 정수, 작은 정수를 반환하는 함수이다.
SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

--MOD 함수는 나머지 값을 구하는 함수이다.
SELECT MOD(15,6), MOD(10,2), MOD(11,2)
FROM DUAL;


SELECT SYSDATE AS NOW, SYSDATE-1 AS YESTERDAY, SYSDATE+1 AS TOMORROW
FROM DUAL;


--ADD_MONTHS 함수는 몇 개월 이후의 날짜를 구하는 함수이다.
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3)
FROM DUAL;

SELECT 1 FROM DUAL WHERE SYSDATE < SYSDATE+1;


--MONTHS_BETWEEN 함수는 2개의 날짜 데이터를 입력하고 두 날짜 간의 개월 수 차이를 구하는 데 사용한다.
--MONTHS_BETWEEN([날짜 데이터1(필수)], [날짜 데이터2(필수)])
--아래와 같이 MONTHS1, MONTHS2에서 알 수 있듯이 비교 날짜의 입력 위치에 따라 음수 또는 양수가 나올 수 있다.
--날짜데이터1 자리에 날짜데이터2보다 미래 날짜가 들어와야 양수 값이 나온다.
--개월 수 차이는 소수점 단위까지 결과가 나오므로 MONTHS3과 같이 TRUNC 함수를 조합하면 개월 수 차이를 정수로 출력할 수도 있다.
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
MONTHS_BETWEEN(HIREDATE,SYSDATE) AS MONTHS1,
MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3
FROM EMP_YOOLIM;


--날짜데이터1 자리에 날짜데이터2보다 미래 날짜가 들어와야 양수 값이 나온다.
SELECT SYSDATE, SYSDATE+30, MONTHS_BETWEEN(SYSDATE
, SYSDATE+30), MONTHS_BETWEEN(SYSDATE+30, SYSDATE) FROM DUAL;


--NEXT_DAY 함수는 날짜 데이터와 요일 문자열을 입력하여 입력한 날짜 데이터에서 돌아오는 요일의 날짜를 반환한다.
--아래 select문은 돌아오는 다음 화요일을 반환한다.
SELECT NEXT_DAY(SYSDATE, '화요일') FROM DUAL;

--LAST_DAY 함수는 하나의 날짜 데이터만을 입력 데이터로 사용하며 해당 날짜가 속한 달의 마지막 날짜를 반환해 주는 함수이다.
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY(TO_DATE('2022-08-01')) FROM DUAL;


--숫자 데이터의 반올림, 버림 처리에 사용한 ROUND, TRUNC 함수는 날짜 데이터를 입력 데이터로 사용할 수도 있다.
--이때는 소수점 위치 정보를 입력하지 않고 반올림, 버림의 기준이 될 포맷값을 지정해준다.
--ROUND([날짜데이터(필수)], [반올림 기준 포맷])
--TRUNC([날짜데이터(필수)], [버림 기준 포맷])
--오라클에서 날짜 데이터를 사용할 때 기준 포맷 값은 다음과 같다.
--CC : 네 자리 연도의 끝 2자리를 기준으로 사용(2016년이면 2050 이하이므로, 반올림할 경우 2001년으로 처리)
--YYYY : 날짜 데이터의 해당 연, 월, 일의 7월 1일을 기준(2016년 7월 1일 일 경우, 2017년으로 처리)
--Q : 각 분기(봄/여름/가을/겨울)의 2번째 달의 16일 기준. 예를 들어 반올림을 한다고 할 때, 여름(6~8월)의 경우, 여름의 2번째 달인 8월 16일 기준으로 8월 16일 이전의 경우 7월 1일로, 8월 16일이나 그 이후의 경우 다음 계절(가을)의 중간 달의 1일(10월 1일)로 된다.
--DDD : 해당 일의 정오(12:00:00)를 기준
--HH : 해당 일의 시간을 기준. 반올림 할때 해당 시간의 30분이 되었을 때(10시 30분이라던지, 11시 30분이라던지...) 다음 시간으로 된다(22:29:59 --> 22:00:00, 22:30:00 --> 23:00:00).

SELECT TO_DATE('2018-07-13 23:56:28', 'YYYY-MM-DD HH24:MI:SS'),
ROUND(TO_DATE('2018-07-13 23:56:28', 'YYYY-MM-DD HH24:MI:SS'), 'CC') AS FORMAT_CC, -- 2018년이면 2050년 이하이므로 반올림하여 2001로 처리
ROUND(TO_DATE('2018-07-13 23:56:28', 'YYYY-MM-DD HH24:MI:SS'), 'YYYY') AS FORMAT_YYYY, -- 7월 13일이면 7월 1일 이후이므로 반올림하여 2019년 1월 1일로 처리
ROUND(TO_DATE('2018-08-16 23:56:28', 'YYYY-MM-DD HH24:MI:SS'), 'Q') AS FORMAT_Q, -- 여름의 2번째 달의 16일인 8월 16일이므로 반올림하여 10월 1일.
ROUND(TO_DATE('2018-07-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'DDD') AS FORMAT_DDD, -- 시간이 정오이므로 반올림하서 7월 14일.
ROUND(TO_DATE('2018-07-13 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'HH') AS FORMAT_HH -- 22시 30분이므로 반올림해서 23시.
FROM DUAL;

SELECT TO_DATE('2018-07-13 23:56:28', 'YYYY-MM-DD HH24:MI:SS'),
TRUNC(TO_DATE('2018-07-13 23:56:28', 'YYYY-MM-DD HH24:MI:SS'), 'CC') AS FORMAT_CC, -- 2018년이면 2050년 이하이므로 반올림하여 2001로 처리
TRUNC(TO_DATE('2018-07-13 23:56:28', 'YYYY-MM-DD HH24:MI:SS'), 'YYYY') AS FORMAT_YYYY, -- 7월 13일이면 7월 1일 이후이므로 반올림하여 2019년 1월 1일로 처리
TRUNC(TO_DATE('2018-08-16 23:56:28', 'YYYY-MM-DD HH24:MI:SS'), 'Q') AS FORMAT_Q, -- 여름의 2번째 달의 16일인 8월 16일이므로 반올림하여 10월 1일.
TRUNC(TO_DATE('2018-07-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'DDD') AS FORMAT_DDD, -- 시간이 정오이므로 반올림하서 7월 14일.
TRUNC(TO_DATE('2018-07-13 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'HH') AS FORMAT_HH -- 22시 30분이므로 반올림해서 23시.
FROM DUAL;


--작은 따옴표로 묶인 500은 문자 데이터이지만, 아래를 실행해보면 EMPNO 값에 숫자 500이 더해진 결과가 나오는데,
--숫자 자료형인 EMPNO열 값과 수치 연산이 가능했던 이유는 '자동 형 변환'이라고 불리는 암시적 형 변환이 발생했기 때문이다.
SELECT EMPNO, EMPNO + '500'
FROM EMP_YOOLIM;


--아래를 실행하면 ORA-01772 수치 부적합 오류가 발생하는데, 숫자처럼 생긴 문자 데이터는 숫자로 바꿔주지만, 그 외의 경우는 잘 동작하길 기대하긴 어렵다.
SELECT 'ABCD'+EMPNO, EMPNO
FROM EMP_YOOLIM;


--오라클에서 자료형이 자동으로 변환되는 방식이 아닌 사용자, 즉 우리가 자료형을 직접 지정해 주는 방식을 명시적 형 변환이라고 한다.
--명시적 형 변환 함수의 종류는 다음과 같다.
--TO_CHAR : 숫자 또는 날짜 데이터를 문자 데이터로 변환
--TO_NUMBER : 문자 데이터를 숫자 데이터로 변환
--TO_DATE : 문자 데이터를 날짜 데이터로 변환
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DY HH24:MI:SS'), TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

--자주 사용하는 날짜 표현 형식은 다음과 같다.
--YYYY : 년(4자리)
--MM : 월(2자리)
--MON : 월(언어별 월 이름 약자)
--MONTH : 월(언어별 월 이름 전체)
--DD : 일(2자리)
--DY : 요일(언어별 요일 이름 약자)
--DAY : 요일(언어별 요일 이름 전체)
SELECT SYSDATE,
TO_CHAR(SYSDATE, 'MM') AS MM,
TO_CHAR(SYSDATE, 'MON') AS MON,
TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
TO_CHAR(SYSDATE, 'DD') AS DD,
TO_CHAR(SYSDATE, 'DY') AS DY,
TO_CHAR(SYSDATE, 'DAY') AS DAY
FROM DUAL;


--만약 이 결과를 특정 언어에 맞는 월, 요일 이름으로 출력하려면 다음과 같이 기존 TO_CHAR 함수에 날짜 출력 언어를 추가로 지정해 줄 수 있다.
--TO_CHAR([날짜데이터(필수)], [출력되길 원하는 문자 형태(필수)], 'NLS_DATE_LANGUAGE = 출력되길 원하는 언어'(선택))
SELECT SYSDATE,
TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KOR,
TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_ENG
FROM DUAL;

--시간을 출력하기 위한 형식은 다음과 같다.
--HH24 : 24시간으로 표현한 시간
--HH, HH12 : 12시간으로 표현한 시간
--MI : 분
--SS : 초
--AM, PM, A.M., P.M. : 오전, 오후 표시
SELECT SYSDATE,
TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM, -- AM으로 하든 PM으로 하든 상관없이 현재 시간이 오전이면 오전, 오후면 오후라고 결과가 출력된다.
TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') AS HHMISS_PM
FROM DUAL;

--숫자 데이터로 출력할 때 지정할 수 있는 형식은 다음과 같다.
--9 : 숫자 한자리를 의미(빈 자리를 채우지 않음)
--0 : 빈자리를 0으로 채움을 의미함
--$ : 달러 표시를 붙여서 출력함
--L : L(Locale) 지역 화폐 단위 기호를 붙여서 출력함
--. : 소수점을 표시함
--, : 천 단위의 구분 기호를 표시함
--이건 솔직히 뭔 말인지 모르겠다... 그리 중요한 것 아닌 것 같으니 그냥 넘어가거나 담에 다시 공부해보자.
SELECT SAL,
TO_CHAR(SAL, '$999,999') AS SAL_$,
TO_CHAR(SAL, 'L999,999') AS SAL_L,
TO_CHAR(SAL, '999,999.00') AS SAL_1,
TO_CHAR(SAL, '000,999,999.00') AS SAL_2,
TO_CHAR(SAL, '$000999999.99') AS SAL_3,
TO_CHAR(SAL, '999,999,00') AS SAL_4
FROM EMP_YOOLIM;


--TO_NUMBER([문자열데이터(필수)], [인식될 숫자 형태(필수)])
SELECT TO_NUMBER('130,000', '999,999') - TO_NUMBER('150,000', '999,999')
FROM DUAL;

--이렇게 하면 130,000 을 숫자로 인식 못함(?)(아마). 그래서 에러 남.
SELECT TO_NUMBER('130,000') - TO_NUMBER('150,000')
FROM DUAL;

--음... 사실 YY과 RR 차이에 대해서 아직 잘 이해 못 함... 근데 그렇게 크게 중요하진 않은 것 같으니 우선 넘어가자.
SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR_49,
TO_DATE('49/12/10', 'RR/MM/DD') AS RR_YEAR_49,
TO_DATE('50/12/10', 'YY/MM/DD') AS YY_YEAR_50,
TO_DATE('50/12/10', 'RR/MM/DD') AS RR_YEAR_50,
TO_DATE('51/12/10', 'YY/MM/DD') AS YY_YEAR_51,
TO_DATE('51/12/10', 'RR/MM/DD') AS RR_YEAR_51
FROM DUAL;


--NVL([NULL인지 여부를 검사할 데이터 또는 열(필수)], [앞의 데이터가 NULL일 경우 반환할 데이터(필수)])
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM, NVL(COMM,0), SAL+NVL(COMM,0)
FROM EMP_YOOLIM;

--NVL2 함수는 NVL 함수와 비슷하지만 데이터가 NULL이 아닐 때 반환할 데이터를 추가로 지정해줄 수 있다.
--NVL2([NULL인지 여부를 검사할 데이터 또는 열(필수)], [앞의 데이터가 NULL일 아닐 경우 반환할 데이터 또는 계산식(필수)], [앞의 데이터가 NULL일 경우 반환할 데이터 또는 계산식(필수)])
SELECT EMPNO, ENAME, COMM, NVL2(COMM,'O','X'), NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL
FROM EMP_YOOLIM;


--DECODE([검사 대상이 될 열 또는 데이터, 연산이나 함수의 결과],
--[조건1], [데이터가 조건1과 일치할 때 반환할 결과],
--[조건2], [데이터가 조건2과 일치할 때 반환할 결과],
--...,
--[조건n], [데이터가 조건n과 일치할 때 반환할 결과],
--[위 조건1~n과 일치한 경우가 없을 때 반환할 결과])
SELECT EMPNO, ENAME, JOB, SAL,
DECODE(JOB,
'MANAGER', SAL*1.1,
'SALESMAN', SAL*1.05,
'ANALYSIS', SAL,
SAL*1.03) AS UPSAL
FROM EMP_YOOLIM;


--CASE문도 DECODE 함수와 마찬가지로 특정 조건에 따라 반환할 데이터를 설정할 때 사용되지만,
--기준 데이터를 반드시 정하고 그 값에 따라 반환 데이터를 정하는 DECODE 함수와 달리 CASE문은 각 조건에 사용하는 데이터가 서로 상관없어도 된다.
--DECODE 함수는 모두 CASE문으로 바꿀 수 있지만, CASE문은 DECODE 함수가 표현할 수 없는 방식도 지원하므로 그 역은 성립하지 않을 수 있다. 즉 CASE문의 범용성이 더 높은 것이다.
SELECT EMPNO, ENAME, JOB, SAL,
CASE JOB -- 기준 데이터 JOB
WHEN 'MANAGER' THEN SAL*1.1
WHEN 'SALESMAN' THEN SAL*1.05
WHEN 'ANALYSIS' THEN SAL
ELSE SAL*1.03
END AS UPSAL
FROM EMP_YOOLIM;

--기준 데이터 없이 조건식만으로 CASE문 사용하기
SELECT EMPNO, ENAME, COMM,
CASE -- 기준 데이터가 없음
WHEN COMM IS NULL THEN '해당사항없음'
WHEN COMM = 0 THEN '수당없음'
WHEN COMM > 0 THEN '수당 : ' || COMM
END AS COMM_TEXT
FROM EMP_YOOLIM;

--EX01
SELECT EMPNO, RPAD(SUBSTR(EMPNO,1,2), LENGTH(EMPNO), '*') AS MASKING_EMPNO, ENAME, RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
FROM EMP_YOOLIM
WHERE LENGTH(ENAME) = 5;

--EX02
SELECT EMPNO, ENAME, SAL,
TRUNC(SAL/21.5, 2) AS DAY_PAY, -- 소수점 세번째 자리에서 버려라(2자리 까지만 나타내라)
ROUND(SAL/21.5/8, 2) AS TIME_PAY -- 소수점 두번째 자리에서 반올림
FROM EMP_YOOLIM;
SELECT TO_CHAR(HIREDATE,'YYYY-MM-DD'),HIREDATE+90 FROM EMP_YOOLIM;

--EX03
SELECT EMPNO, ENAME, TO_CHAR(HIREDATE, 'YYYY/MM/DD') AS HIREDATE, TO_CHAR(NEXT_DAY(HIREDATE+90, '월요일'), 'YYYY-MM-DD') AS R_JOB
--, NVL(COMM,'N/A') AS COMM --> 이렇게 하면 에러난다. COMM이 NULL일 때 'N/A'로 대체하라는건데, COMM은 애초에 타입이 NUMBER이므로 문자열인 'N/A'로 대체할 수 없음.
, DECODE(COMM, NULL, 'N/A',COMM)
FROM EMP_YOOLIM;

--EX04
SELECT EMPNO, ENAME, MGR
--, DECODE(MGR, NULL, '0000', SUBSTR(MGR,1,2) = '75', '5555')
, CASE
WHEN MGR IS NULL THEN '0000'
WHEN MGR = SUBSTR(MGR,1,2) = '75' THEN '5555'
WHEN MGR = SUBSTR(MGR,1,2) = '76' THEN '6666'
WHEN MGR = SUBSTR(MGR,1,2) = '77' THEN '7777'
WHEN MGR = SUBSTR(MGR,1,2) = '78' THEN '8888'
ELSE MGR
END AS CHG_MGR
FROM EMP_YOOLIM;