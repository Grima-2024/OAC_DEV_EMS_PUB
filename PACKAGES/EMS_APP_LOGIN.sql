--------------------------------------------------------
--  DDL for Package EMS_APP_LOGIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."EMS_APP_LOGIN" AS  
---------------------------------------------------------------------------------------------------------------------- 
--------------==================This package contains code for Custom Authentication===================-------------- 
---------------------------------------------------------------------------------------------------------------------- 

FUNCTION login ( p_username IN VARCHAR2 , p_password IN VARCHAR2)  RETURN BOOLEAN; 

END EMS_APP_LOGIN; 

/
