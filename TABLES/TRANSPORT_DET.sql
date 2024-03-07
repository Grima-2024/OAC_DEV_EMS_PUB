--------------------------------------------------------
--  DDL for Table TRANSPORT_DET
--------------------------------------------------------

  CREATE TABLE "INSTITUTE"."TRANSPORT_DET" 
   (	"TRANSPORT_ID" NUMBER, 
	"STUDENT_ID" NUMBER, 
	"POINT_ID" NUMBER, 
	"VEHICAL_ID" NUMBER, 
	"TRANSPORT_CODE" VARCHAR2(20 BYTE) COLLATE "USING_NLS_COMP", 
	"CREATED_BY" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"CREATED_ON" TIMESTAMP (6), 
	"UPDATED_BY" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"UPDATED_ON" TIMESTAMP (6)
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
