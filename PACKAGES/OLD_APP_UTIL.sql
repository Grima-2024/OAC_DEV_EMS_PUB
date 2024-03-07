--------------------------------------------------------
--  DDL for Package OLD_APP_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."OLD_APP_UTIL" as 
 
      /*********************************************************************************
     //    Package Contain utility function for entire application  function  
    //     CREATED By : Mayur Vaghasiya   CREATED ON: 
   //      UPDATED By : Mayur Vaghasiya   UPDATED ON: 
   ********************************************************************************/ 
   
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL GLOBAL DECLARATION HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
 
 
 
 
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL FUNCTION HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
 
FUNCTION chk_valid_username( 
    p_username IN varchar2)  
    RETURN BOOLEAN; 
 
FUNCTION chk_password_policy( 
    p_password IN varchar2)  
    RETURN BOOLEAN;
     
FUNCTION get_usertypeid_fromrole( 
    p_user_type_code IN VARCHAR2, 
    p_inst_id IN NUMBER)  
    RETURN NUMBER;

FUNCTION get_rolenamefrom_id( 
    p_user_type_id IN number)  
    RETURN varchar2; 
     
FUNCTION get_rolenamefrom_code( 
    p_user_type_code IN varchar2)  
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
     
FUNCTION get_academicyear_byid( 
    p_ac_year_id IN number)  
    RETURN varchar2;  
         
FUNCTION get_ac_startyear_byid( 
    p_ac_year_id IN number)  
    RETURN varchar2;  
     
FUNCTION get_ac_endyear_byid( 
    p_ac_year_id IN number)  
    RETURN varchar2;  
     
FUNCTION get_fullmediumname( 
    p_medium_id IN number)  
    RETURN varchar2; 
     
FUNCTION get_mediumcode( 
    p_medium_id IN number)  
    RETURN varchar2;     
     
FUNCTION get_fullstdname( 
    p_std_id IN number)  
    RETURN varchar2; 
     
FUNCTION get_stdcode( 
    p_std_id IN number)  
    RETURN varchar2;       
         
FUNCTION get_fullsemname( 
    p_sem_id IN number)  
    RETURN varchar2; 
     
FUNCTION get_semcode( 
    p_sem_id IN number)  
    RETURN varchar2;   
     
FUNCTION get_fulldivisionname( 
    p_div_id IN number)  
    RETURN varchar2; 
     
FUNCTION get_divisioncode( 
    p_div_id IN number)  
    RETURN varchar2;        
     
FUNCTION get_fullsubjectname( 
    p_sub_id IN number)  
    RETURN varchar2; 
     
FUNCTION get_subjectcode( 
    p_sub_id IN number)  
    RETURN varchar2;        
 
FUNCTION get_emailtemplate_byuserid( 
    p_user_id IN number)  
    RETURN clob;  
     
FUNCTION chk_active_emailtemplate( 
    p_user_id IN number)  
    RETURN boolean;  
     
FUNCTION get_studentfullname_byid( 
    p_std_id IN number)  
    RETURN varchar2;        
     
FUNCTION get_studentname_byid( 
    p_std_id IN number)  
    RETURN varchar2;        
     
FUNCTION get_calculate_age( 
    p_birth_date IN varchar2)  
    RETURN varchar2;        
         
FUNCTION chk_agelimit_for_admission( 
    p_limityear IN number, 
    p_birth_date IN varchar2)  
    RETURN boolean;    
     
FUNCTION password_compare( 
    p_password IN varchar2, 
    p_confirm_pwd IN varchar2)  
    RETURN boolean;  
     
FUNCTION compare_newandold_password( 
    p_username IN varchar2, 
    p_oldpassword IN varchar2)  
    RETURN boolean;  
 
FUNCTION get_country_byid( 
    p_country_id IN number)  
    RETURN varchar2; 
 
FUNCTION get_state_byid( 
    p_state_id IN number)  
    RETURN varchar2; 
 
FUNCTION get_employeename_byid( 
    p_employee_id IN number)  
    RETURN varchar2; 

FUNCTION get_empid_byusername( 
    p_username IN varchar2,
    p_inst_id IN NUMBER)  
    RETURN number; 

FUNCTION chk_valid_email( 
    p_email IN varchar2)  
    RETURN boolean;     
   
FUNCTION chk_specialcharnotallow( 
    p_str IN varchar2)  
    RETURN boolean;  
     
FUNCTION chk_onlycharacterallow( 
    p_str IN varchar2)  
    RETURN boolean;  
 
FUNCTION chk_onlynumberallow( 
    p_str IN varchar2)  
    RETURN boolean;  
 
FUNCTION get_userid_fromname( 
    p_user_name in varchar2) 
    return number; 
     
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL PROCEDURE HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
PROCEDURE SEND_EMAIL( 
           p_to     IN varchar2, 
           p_from   IN varchar2, 
           p_subj   IN varchar2 default null); 
end; 

/
