--------------------------------------------------------
--  Ref Constraints for Table EMP
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMP" ADD CONSTRAINT "EMP_MGR_FK" FOREIGN KEY ("MGR")
	  REFERENCES "INSTITUTE"."EMP" ("EMPNO") ENABLE;
  ALTER TABLE "INSTITUTE"."EMP" ADD CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPTNO")
	  REFERENCES "INSTITUTE"."DEPT" ("DEPTNO") ENABLE;
