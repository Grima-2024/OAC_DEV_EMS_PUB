--------------------------------------------------------
--  DDL for Package AEP_CUSTOM_LOGIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."AEP_CUSTOM_LOGIN" AS   
 
	FUNCTION AEP_login ( 
		p_username IN VARCHAR2,  
		p_password IN VARCHAR2)   
	RETURN BOOLEAN;  
 
END AEP_CUSTOM_LOGIN;

/
