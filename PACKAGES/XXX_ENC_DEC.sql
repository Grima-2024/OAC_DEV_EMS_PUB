--------------------------------------------------------
--  DDL for Package XXX_ENC_DEC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."XXX_ENC_DEC" AS

FUNCTION encrypt_pwd (p_text IN VARCHAR2) 
RETURN RAW;
  
FUNCTION decrypt_pwd (p_raw IN RAW) 
RETURN VARCHAR2;

PROCEDURE padstring (p_text IN OUT VARCHAR2);
  
END XXX_ENC_DEC;

/
