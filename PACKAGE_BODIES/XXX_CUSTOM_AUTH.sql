--------------------------------------------------------
--  DDL for Package Body XXX_CUSTOM_AUTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."XXX_CUSTOM_AUTH" AS 

FUNCTION XXX_auth_right(p_app_user IN VARCHAR, p_usertype IN VARCHAR2)
RETURN BOOLEAN
IS
	l_usr_type VARCHAR2(20);
BEGIN
	SELECT UPPER(USER_TYPE_NAME) INTO l_usr_type 
	FROM XXX_USER_TYPE_MST
	WHERE USER_TYPE_ID = (SELECT USER_TYPE_ID FROM XXX_USER_MST WHERE UPPER(USERNAME) = UPPER(p_app_user));

	IF NVL(l_usr_type,'X') = p_usertype THEN
		--HTP.P('TRUE');
		RETURN TRUE;
	ELSE
		HTP.P('TRUE');
		--RETURN FALSE;
	END IF; 

    --EXCEPTION WHEN NO_DATA_FOUND THEN logger.log_error('User Not Found');
        --RETURN FALSE; 
END XXX_auth_right; 
 
END XXX_CUSTOM_AUTH;

/
