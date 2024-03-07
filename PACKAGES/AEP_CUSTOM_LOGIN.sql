--------------------------------------------------------
--  DDL for Package AEP_CUSTOM_LOGIN
--------------------------------------------------------

CREATE OR REPLACE PACKAGE "AEP_CUSTOM_LOGIN" AS   
 
	FUNCTION AEP_login ( 
		p_username IN VARCHAR2,  
		p_password IN VARCHAR2)   
	RETURN BOOLEAN;  
	
	--NEW ADDED
END AEP_CUSTOM_LOGIN;

/
