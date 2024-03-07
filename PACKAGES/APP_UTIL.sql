--------------------------------------------------------
--  DDL for Package APP_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."APP_UTIL" as 

FUNCTION get_usertypeid_fromrole( 
    p_user_type_code IN VARCHAR2, 
    p_inst_id IN NUMBER)  
    RETURN NUMBER;

FUNCTION get_usertypeid_fromusername( 
    p_username IN VARCHAR2, 
    p_inst_id IN NUMBER)  
    RETURN NUMBER;

FUNCTION get_rolenamefrom_id( 
    p_user_type_id IN number)  
    RETURN varchar2; 
     
FUNCTION get_usernamefrom_id( 
    p_user_id IN number)  
    RETURN varchar2; 
     
FUNCTION get_useridfrom_username( 
    p_user_name IN varchar2)  
    RETURN number;     

FUNCTION get_instituteid_byusername(
    p_username IN VARCHAR2)
    RETURN NUMBER;

FUNCTION get_institutename_byid( 
    p_institute_id IN number)  
    RETURN varchar2;   
     
FUNCTION get_inst_name_with_code( 
    p_institute_id IN number)  
    RETURN varchar2;    

FUNCTION get_studentfullname_byid( 
    p_std_id IN number)  
    RETURN varchar2;

FUNCTION get_calculate_age( 
    p_birth_date IN varchar2)  
    RETURN varchar2;            
     
FUNCTION get_employeename_byid( 
    p_employee_id IN number)  
    RETURN varchar2; 

FUNCTION get_empid_byusername( 
    p_username IN varchar2,
    p_inst_id IN NUMBER)  
    RETURN number; 
 
FUNCTION get_userid_fromname( 
    p_user_name in varchar2) 
    return number; 
    
END APP_UTIL;

/
