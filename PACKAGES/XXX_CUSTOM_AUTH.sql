--------------------------------------------------------
--  DDL for Package XXX_CUSTOM_AUTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."XXX_CUSTOM_AUTH" AS  

FUNCTION XXX_AUTH_RIGHT(p_app_user IN VARCHAR, p_usertype IN VARCHAR2)  
RETURN BOOLEAN; 

END XXX_CUSTOM_AUTH;

/
