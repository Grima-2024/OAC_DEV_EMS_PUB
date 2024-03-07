--------------------------------------------------------
--  DDL for Table MOVERGEOG_JSON
--------------------------------------------------------

  CREATE TABLE "INSTITUTE"."MOVERGEOG_JSON" 
   (	"ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"ZIPCODE" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP", 
	"MOVER_ID" VARCHAR2(32767 BYTE) COLLATE "USING_NLS_COMP", 
	"VERIFIED_LOC" VARCHAR2(32767 BYTE) COLLATE "USING_NLS_COMP", 
	"VERIFIED_INTE" VARCHAR2(32767 BYTE) COLLATE "USING_NLS_COMP", 
	"ELITE_LOC" VARCHAR2(32767 BYTE) COLLATE "USING_NLS_COMP", 
	"ELITE_INTE" VARCHAR2(32767 BYTE) COLLATE "USING_NLS_COMP"
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;