--------------------------------------------------------
--  DDL for Package XXX_CUSTOM_LOGIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."XXX_CUSTOM_LOGIN" AS  

FUNCTION xxx_login (
	p_username IN VARCHAR2, 
	p_password IN VARCHAR2)  
RETURN BOOLEAN; 

END XXX_CUSTOM_LOGIN;

/
