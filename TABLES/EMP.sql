--------------------------------------------------------
--  DDL for Table EMP
--------------------------------------------------------

  CREATE TABLE "INSTITUTE"."EMP" 
   (	"EMPNO" NUMBER(4,0) GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 90000 INCREMENT BY 10 START WITH 8000 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"ENAME" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP", 
	"JOB" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP", 
	"MGR" NUMBER(4,0), 
	"HIREDATE" DATE, 
	"SAL" NUMBER(7,2), 
	"COMM" NUMBER(7,2), 
	"DEPTNO" NUMBER(4,0)
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
