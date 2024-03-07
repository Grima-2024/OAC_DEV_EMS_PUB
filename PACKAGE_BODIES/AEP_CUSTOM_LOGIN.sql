--------------------------------------------------------
--  DDL for Package Body AEP_CUSTOM_LOGIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."AEP_CUSTOM_LOGIN" AS  
 
FUNCTION AEP_login(p_username IN VARCHAR2, p_password IN VARCHAR2)  
RETURN BOOLEAN 
IS 
    v_count NUMBER;  
    l_password  AEP_USER_MST.password%type; 
BEGIN   
	--Check whether user exists with username or not.. if exists match password and Return TRUE else Return FALSE 
    SELECT count(*) into v_count   
    FROM AEP_USER_MST   
    WHERE TRIM(UPPER(USERNAME)) = TRIM(UPPER(p_username)); 
             
    IF v_count >= 1 THEN        
         
        select AEP_ENC_DEC.decrypt_pwd(password) 
        into l_password  
        FROM AEP_USER_MST   
        WHERE TRIM(UPPER(USERNAME)) = TRIM(UPPER(p_username)); 
   
        -- Compare the two, and if there is a match, Return TRUE else Return FALSE 
        IF p_password = l_password THEN 
            APEX_UTIL.SET_AUTHENTICATION_RESULT(0); 
            RETURN true; 
        ELSE 
            APEX_UTIL.SET_AUTHENTICATION_RESULT(4); 
            RETURN false; 
        END IF; 
    ELSE  
        RETURN FALSE;  
    END IF;  
        
    EXCEPTION WHEN NO_DATA_FOUND THEN logger.log_error('User Not Found'); 
        RETURN FALSE;  
END AEP_login;  
  
END AEP_CUSTOM_LOGIN;

/
