--------------------------------------------------------
--  DDL for Table STUDENT_LEAVE_DETAILS
--------------------------------------------------------

  CREATE TABLE "INSTITUTE"."STUDENT_LEAVE_DETAILS" 
   (	"LEAVE_ID" NUMBER, 
	"LEAVE_TYPE_ID" NUMBER, 
	"STUDENT_ID" NUMBER, 
	"MED_ID" NUMBER, 
	"STD_ID" NUMBER, 
	"SEM_ID" NUMBER, 
	"DIV_ID" NUMBER, 
	"FROM_DATE" DATE, 
	"TO_DATE" DATE, 
	"INSTITUTE_ID" NUMBER, 
	"AC_YEAR_ID" NUMBER, 
	"NO_OF_DAYS" NUMBER, 
	"EMPLOYEE_ID" NUMBER
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
