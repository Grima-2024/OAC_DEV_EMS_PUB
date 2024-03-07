--------------------------------------------------------
--  DDL for Package AEP_CUSTOM_AUTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."AEP_CUSTOM_AUTH" AS  
 
	FUNCTION AEP_AUTH_RIGHT(p_app_user IN VARCHAR, p_usertype IN VARCHAR2)   
	RETURN BOOLEAN;  
 
END AEP_CUSTOM_AUTH; 

/
