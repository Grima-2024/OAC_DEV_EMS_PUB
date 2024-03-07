--------------------------------------------------------
--  DDL for Package DV_TEST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."DV_TEST" AS  
 
	FUNCTION DV_TEST1(p_app_user IN VARCHAR, p_usertype IN VARCHAR2)   
	RETURN BOOLEAN;  
 
END DV_TEST;

/
