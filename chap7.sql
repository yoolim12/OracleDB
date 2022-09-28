--다중행 함수는 여러 행이 입력되어 하나의 행으로 결과가 출력되는 특징을 가지고 있다.
--이러한 특징으로 다중행 함수를 사용한 SELECT절에는 아래와 같이 기본적으로 여러 행이 결과로 나올 수 있는 열을 함께 사용할 수가 없다.
--아래 코드를 실행하면 ORA-00937: 단일 그룹의 그룹 함수가 아닙니다. 에러가 나오는데,
--이 오류는 아래와 같이 SELECT절에 다중행 함수를 사용하여 결과값이 한 행으로 나오는 데이터(SUM(SAL))와 여러 행이 나올 수 있는 데이터(ENAME)를 함께 명시했을 때 발생한다.
--SUM은 NULL 데이터는 제외하고 합계를 구한다.
SELECT ENAME, SUM(SAL) FROM EMP_YOOLIM;


--자주 사용하는 다중행 함수
--1. SUM 2. COUNT 3. MAX 4. MIN 5. AVG


SELECT SUM(DISTINCT SAL), SUM(ALL SAL), SUM(SAL)
FROM EMP_YOOLIM;


--COUNT 또한 NULL 데이터는 제외한 개수를 구한다.
--GROUP BY절에 명시하는 열은 여러 개 지정할 수 있다.
--먼저 지정한 열로 대그룹을 나누고 그 다음 지정한 열로 소그룹을 나눈다.
--GROUP BY절에는 별칭이 인식되지 않는다. 즉 열 이름이나 연산식을 그대로 지정해주어야 한다.
--각 부서의 직책별 평균 급여를 알고 싶다면 GROUP BY절에 JOB열을 추가로 명시하여 아래와 같이 작성하면 된다.
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP_YOOLIM
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;


--GROUP BY절을 사용하여 출력 데이터를 그룹화할 경우 유의해야 할 점이 있는데 바로 다중행 함수를 사용하지 않은 일반 열은 GROUP BY절에 명시하지 않으면 SELECT 절에서 사용할 수 없다는 것이다.
----다음과 같이 GROUP BY절에 명시하지 않은 ENAME열을 출력하도록 작성한 SELECT문을 실행해보면 에러가 발생하는 것을 볼 수 있다.
--에러가 발생하는 이유는 DEPTNO를 기준으로 그룹화되어 DEPTNO열과 AVG(SAL)열은 한 행으로 출력되지만, ENAME열은 여러 행으로 구성되어 각 열별 데이터 수가 달라져 출력이 불가능해지기 때문이다.
--앞에서 다중행 함수를 처음 소개할 때 발생한 ORA-00937 오류와 비슷한 원인이다.
--따라서 GROUP BY절을 사용한 그룹화는 그룹화된 열 외에 일반 열을 SELECT절에 명시할 수 없다.
SELECT ENAME, DEPTNO, AVG(SAL)
FROM EMP_YOOLIM
GROUP BY DEPTNO;


--HAVING절은 GROUP BY절을 통해 그룹화된 결과 값의 범위를 제한하는 데 사용한다.
--HAVING절과 WHERE절이 조건식을 지정한다는 점에서 비슷해보이나, WHERE절은 출력 대상 행을 제한하고, HAVING절은 그룹화된 대상을 출력에서 제한한다는 점에서 쓰임이 다르다.
--아래 코드를 실행하면 ORA-00934: 그룹 함수는 허가되지 않습니다. 라는 에러가 뜨는데, 이는 출력 행을 제한하는 WHERE절에서는 그룹화된 데이터 AVG(SAL)를 제한하는 조건식을 지정할 수 없기 때문이다.
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP_YOOLIM
WHERE AVG(SAL) >= 2000
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;


--아래와 같이 WHERE절에 그룹화된 행이 아닌 행으로 지정해줄 경우 가능
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP_YOOLIM
WHERE SAL <= 3000
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;


--이후 내용(P.195부터의 CHAP7 내용들)은 비교적 덜 중요한 부분들이니까 나중에 자세히 살펴보자.