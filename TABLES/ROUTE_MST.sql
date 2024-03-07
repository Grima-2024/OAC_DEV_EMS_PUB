--------------------------------------------------------
--  DDL for Table ROUTE_MST
--------------------------------------------------------

  CREATE TABLE "INSTITUTE"."ROUTE_MST" 
   (	"ROUTE_ID" NUMBER, 
	"ROUTE_NAME" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"ROUTE_CODE" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP", 
	"VEHICAL_ID" NUMBER, 
	"INSTITUTE_ID" NUMBER, 
	"CREATED_BY" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP", 
	"CREATED_ON" TIMESTAMP (6), 
	"UPDATED_BY" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP", 
	"UPDATED_ON" TIMESTAMP (6)
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
