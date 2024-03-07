--------------------------------------------------------
--  DDL for Package Body APP_LOGIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."APP_LOGIN" AS 

FUNCTION login(p_username IN VARCHAR2 ,p_password IN VARCHAR2) 
RETURN BOOLEAN 
IS
    v_count NUMBER; 
    --l_username  USERS_MST.username%type;-- := upper(p_username);
    l_password  USERS_MST.password%type;
BEGIN  
    SELECT count(*) into v_count  
    FROM USERS_MST  
    WHERE TRIM(UPPER(USERNAME)) = TRIM(UPPER(p_username));
            
    IF v_count >= 1 THEN       
        
        select EMS_ENC_DEC.decrypt(password)
        into l_password 
        FROM USERS_MST  
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
END login; 
 
END APP_LOGIN; 

/
