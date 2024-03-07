--------------------------------------------------------
--  DDL for Package APP_LOGIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."APP_LOGIN" AS  
    FUNCTION login ( p_username IN VARCHAR2 , p_password IN VARCHAR2)  RETURN BOOLEAN  ; 
END APP_LOGIN; 

/
