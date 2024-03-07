--------------------------------------------------------
--  DDL for Package EMS_ENC_DEC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."EMS_ENC_DEC" AS

---------------------------------------------------------------------------------------------------------------------- 
----------==============This package contains code for Encryption and Decryption of Password==============------------ 
---------------------------------------------------------------------------------------------------------------------- 

FUNCTION encrypt (p_text  IN  VARCHAR2) RETURN RAW;
  
FUNCTION decrypt (p_raw  IN  RAW) RETURN VARCHAR2;

PROCEDURE padstring (p_text  IN OUT  VARCHAR2);
  
END EMS_ENC_DEC;

/
