--------------------------------------------------------
--  DDL for Table AT_STUD_ATTENDANCE
--------------------------------------------------------

  CREATE TABLE "INSTITUTE"."AT_STUD_ATTENDANCE" 
   (	"ATTEND_ID" NUMBER, 
	"EMPLOYEE_ID" NUMBER, 
	"STUDENT_ID" NUMBER, 
	"ATTEND_DT" DATE, 
	"ATTEND_STATUS" VARCHAR2(10 BYTE) COLLATE "USING_NLS_COMP", 
	"REMARKS" VARCHAR2(200 BYTE) COLLATE "USING_NLS_COMP", 
	"STD_ID" NUMBER, 
	"SEM_ID" NUMBER, 
	"DIV_ID" NUMBER, 
	"AC_YEAR_ID" NUMBER, 
	"CREATED_BY" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"CREATED_ON" TIMESTAMP (6), 
	"UPDATED_BY" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"UPDATED_ON" TIMESTAMP (6), 
	"SUBJECT" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"SCHEDULE_ID_FK" NUMBER, 
	"INSTITUTE_ID" NUMBER, 
	"MED_ID" NUMBER
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
