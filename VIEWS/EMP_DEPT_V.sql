--------------------------------------------------------
--  DDL for View EMP_DEPT_V
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "INSTITUTE"."EMP_DEPT_V" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO", "DNAME", "LOC") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  select e.empno
,      e.ename
,      e.job
,      (select m.ename from emp m where e.mgr = m.empno) mgr
,      e.hiredate
,      e.sal
,      e.comm
,      d.deptno
,      d.dname
,      d.loc
from emp e
,    dept d
where e.deptno = d.deptno (+)
;
