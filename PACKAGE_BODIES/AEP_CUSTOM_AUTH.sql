--------------------------------------------------------
--  DDL for Package Body AEP_CUSTOM_AUTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."AEP_CUSTOM_AUTH" AS  
 
FUNCTION AEP_auth_right(p_app_user IN VARCHAR, p_usertype IN VARCHAR2) 
RETURN BOOLEAN 
IS 
	l_usr_type VARCHAR2(20); 
BEGIN 
	SELECT UPPER(USER_TYPE_NAME) INTO l_usr_type  
	FROM AEP_USER_TYPE_MST 
	WHERE USER_TYPE_ID = (SELECT USER_TYPE_ID FROM AEP_USER_MST WHERE UPPER(USERNAME) = UPPER(p_app_user)); 
 
	IF NVL(l_usr_type,'X') = p_usertype THEN 
		RETURN TRUE; 
	ELSE 
		RETURN FALSE; 
	END IF;  
 
    EXCEPTION WHEN NO_DATA_FOUND THEN logger.log_error('User Not Found'); 
        RETURN FALSE; 
		 
END AEP_auth_right;  
  
END AEP_CUSTOM_AUTH; 

/
