--------------------------------------------------------
--  DDL for Package Body OLD_APP_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."OLD_APP_UTIL" is 
 
      /******************************************************************************** 
     //    Package Contain utility function for entire application  function  
    //     CREATED By : Mayur Vaghasiya   CREATED ON: 
   //      UPDATED By : Mayur Vaghasiya   UPDATED ON: 
   ********************************************************************************/ 
   
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL GLOBAL DECLARATION HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.'; 
 
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL FUNCTION HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
 
 
 
 
FUNCTION chk_valid_username( 
    p_username in varchar2)  
    RETURN BOOLEAN 
AS 
 
    l_count number;     
    l_scope logger_logs.scope%type := gc_scope_prefix || 'chk_valid_username'; 
    l_params logger.tab_param; 
     
BEGIN 
     
    SELECT count(*) INTO  l_count  FROM USERS_MST WHERE username = p_username; 
    IF l_count <= 0 THEN 
         return true; 
    ELSE 
         return false; 
    END IF; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
 
END chk_valid_username; 
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION chk_password_policy( 
    p_password in varchar2)  
    RETURN BOOLEAN 
AS     
BEGIN 
    return false; 
END chk_password_policy; 

------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_usertypeid_fromrole( 
    p_user_type_code IN VARCHAR2, 
    p_inst_id IN NUMBER)  
    RETURN NUMBER 
AS   
    l_utypeid NUMBER;
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_rolenamefrom_id'; 
    l_params logger.tab_param; 
BEGIN 
    select user_type_id into l_utypeid from users_type_mst where user_type_code = p_user_type_code and institute_id = p_inst_id;  
    return l_utypeid; 
 
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
     
END get_usertypeid_fromrole;

------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_rolenamefrom_id( 
    p_user_type_id IN number)  
    RETURN varchar2 
AS   
    l_rolename varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_rolenamefrom_id'; 
    l_params logger.tab_param; 
BEGIN 
    select user_type_code into l_rolename from users_type_mst where user_type_id= p_user_type_id;  
    return l_rolename; 
 
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
     
END get_rolenamefrom_id;   
 
------------------------------------------------------------------------------------------------------------ 
     
FUNCTION get_rolenamefrom_code( 
    p_user_type_code IN varchar2)  
    RETURN varchar2   
AS  
    l_rolename varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_rolenamefrom_code'; 
    l_params logger.tab_param; 
BEGIN 
    select user_type_code into l_rolename from users_type_mst where USER_TYPE_CODE = p_user_type_code;   
    return l_rolename; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_rolenamefrom_code; 
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_usernamefrom_id( 
    p_user_id IN number)  
    RETURN varchar2   
AS  
    l_username varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_usernamefrom_id'; 
    l_params logger.tab_param; 
BEGIN 
    select username into l_username from users_mst where user_id = p_user_id;   
    return l_username; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_usernamefrom_id; 
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_useridfrom_username( 
    p_user_name IN varchar2)  
    RETURN number 
AS  
    l_userid varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_usernamefrom_id'; 
    l_params logger.tab_param; 
BEGIN 
    select user_id into l_userid from users_mst where UPPER(username) = UPPER(p_user_name);   
    return l_userid; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_useridfrom_username; 
 
------------------------------------------------------------------------------------------------------------ 

FUNCTION get_instituteid_byusername(p_username IN VARCHAR2)
    RETURN NUMBER 
AS   
    l_inst_id NUMBER;
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_rolenamefrom_id'; 
    l_params logger.tab_param; 
BEGIN 
    SELECT INSTUTUTE_ID into l_inst_id FROM USERS_MST WHERE UPPER(USERNAME) = UPPER(p_username);
    return l_inst_id; 
 
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
     
END get_instituteid_byusername;

------------------------------------------------------------------------------------------------------------ 

FUNCTION get_institutename_byid( 
    p_institute_id IN number)  
    RETURN varchar2 
AS  
    l_instname varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_institutename_byid'; 
    l_params logger.tab_param; 
BEGIN 
    select institute_name into l_instname from institute_mst where institute_id = p_institute_id;   
    return l_instname; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_institutename_byid; 
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_inst_name_with_code( 
    p_institute_id IN number)  
    RETURN varchar2 
AS  
    l_instname varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_inst_name_with_code'; 
    l_params logger.tab_param; 
BEGIN 
    select inst_code||' - '||institute_name into l_instname from institute_mst where institute_id = p_institute_id;   
    return l_instname; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_inst_name_with_code; 
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_academicyear_byid( 
    p_ac_year_id IN number)  
    RETURN varchar2  
AS  
    l_year_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_academicyear_byid'; 
    l_params logger.tab_param; 
BEGIN 
    select year_name into l_year_name from academic_year_mst where ac_year_id = p_ac_year_id;   
    return l_year_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_academicyear_byid; 
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_ac_startyear_byid( 
    p_ac_year_id IN number)  
    RETURN varchar2 
AS  
    l_year_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_ac_startyear_byid'; 
    l_params logger.tab_param; 
BEGIN 
    select start_year into l_year_name from academic_year_mst where ac_year_id = p_ac_year_id;   
    return l_year_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_ac_startyear_byid;     
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_ac_endyear_byid( 
    p_ac_year_id IN number)  
    RETURN varchar2 
AS  
    l_year_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_ac_endyear_byid'; 
    l_params logger.tab_param; 
BEGIN 
    select end_year into l_year_name from academic_year_mst where ac_year_id = p_ac_year_id;   
    return l_year_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_ac_endyear_byid;     
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_fullmediumname( 
    p_medium_id IN number)  
    RETURN varchar2 
AS  
    l_med_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_fullmediumname'; 
    l_params logger.tab_param; 
BEGIN 
    select medium_name into l_med_name from medium_mst where med_id = p_medium_id;   
    return l_med_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_fullmediumname;      
 
------------------------------------------------------------------------------------------------------------    
 
FUNCTION get_mediumcode( 
    p_medium_id IN number)  
    RETURN varchar2     
AS  
    l_medsrt_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_mediumcode'; 
    l_params logger.tab_param; 
BEGIN 
    select med_short_name into l_medsrt_name from medium_mst where med_id = p_medium_id;   
    return l_medsrt_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_mediumcode;      
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_fullstdname( 
    p_std_id IN number)  
    RETURN varchar2 
AS  
    l_std_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_fullstdname'; 
    l_params logger.tab_param; 
BEGIN 
    select std_name into l_std_name from standard_mst where std_id = p_std_id;   
    return l_std_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_fullstdname;       
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_stdcode( 
    p_std_id IN number)  
    RETURN varchar2   
AS  
    l_stdsrt_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_stdcode'; 
    l_params logger.tab_param; 
BEGIN 
    select std_short_name into l_stdsrt_name from standard_mst where std_id = p_std_id;   
    return l_stdsrt_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_stdcode;       
     
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_fullsemname( 
    p_sem_id IN number)  
    RETURN varchar2 
AS  
    l_sem_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_fullsemname'; 
    l_params logger.tab_param; 
BEGIN 
    select sem_name into l_sem_name from semester_mst where sem_id = p_sem_id;   
    return l_sem_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_fullsemname;      
 
------------------------------------------------------------------------------------------------------------   
 
FUNCTION get_semcode( 
    p_sem_id IN number)  
    RETURN varchar2    
AS  
    l_semsrt_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_semcode'; 
    l_params logger.tab_param; 
BEGIN 
    select sem_code into l_semsrt_name from semester_mst where sem_id = p_sem_id;   
    return l_semsrt_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_semcode;  
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_fulldivisionname( 
    p_div_id IN number)  
    RETURN varchar2 
AS  
    l_div_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_fulldivisionname'; 
    l_params logger.tab_param; 
BEGIN 
    select div_name into l_div_name from division_mst where division_id = p_div_id;   
    return l_div_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_fulldivisionname;      
 
------------------------------------------------------------------------------------------------------------  
 
FUNCTION get_divisioncode( 
    p_div_id IN number)  
    RETURN varchar2        
AS  
    l_div_code varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_divisioncode'; 
    l_params logger.tab_param; 
BEGIN 
    select div_code into l_div_code from division_mst where division_id = p_div_id;   
    return l_div_code; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_divisioncode;      
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_fullsubjectname( 
    p_sub_id IN number)  
    RETURN varchar2 
AS  
    l_sub_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_fullsubjectname'; 
    l_params logger.tab_param; 
BEGIN 
    select subject_name into l_sub_name from subject_mst where sub_id = p_sub_id;   
    return l_sub_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_fullsubjectname;  
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_subjectcode( 
    p_sub_id IN number)  
    RETURN varchar2 
AS  
    l_sub_code varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_subjectcode'; 
    l_params logger.tab_param; 
BEGIN 
    select sub_code into l_sub_code from subject_mst where sub_id = p_sub_id;   
    return l_sub_code; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_subjectcode;    
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_emailtemplate_byuserid( 
    p_user_id IN number)  
    RETURN clob 
AS  
    l_email_template clob; 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_emailtemplate_byuserid'; 
    l_params logger.tab_param; 
BEGIN 
    select TEMPLATE_BODY into l_email_template from EMAIL_TEMPLATE where USER_ID = p_user_id and status = 1;   
    return l_email_template; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_emailtemplate_byuserid;  
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION chk_active_emailtemplate( 
    p_user_id IN number)  
    RETURN boolean 
AS  
    l_count number; 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'chk_active_emailtemplate'; 
    l_params logger.tab_param; 
BEGIN 
    select count(*) into l_count from EMAIL_TEMPLATE where USER_ID = p_user_id and status = 1;   
     
    IF l_count <= 0 then  
        return true; 
    else 
        return false; 
    end if; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END chk_active_emailtemplate;  
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_studentfullname_byid( 
    p_std_id IN number)  
    RETURN varchar2     
AS  
    l_fullname varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_studentfullname_byid'; 
    l_params logger.tab_param; 
BEGIN 
    select INITCAP(firstname||' '||middlename||' '||lastname) into l_fullname from students_det where student_id = p_std_id;   
    return l_fullname; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_studentfullname_byid;  
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_studentname_byid( 
    p_std_id IN number)  
    RETURN varchar2  
AS  
    l_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_studentname_byid'; 
    l_params logger.tab_param; 
BEGIN 
    select firstname||' '||lastname into l_name from students_det where student_id = p_std_id;   
    return l_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_studentname_byid;  
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_calculate_age( 
    p_birth_date IN varchar2)  
    RETURN varchar2 
AS  
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_calculate_age'; 
    l_params logger.tab_param; 
    l_your_age   NUMBER(3, 1);    
     
     
BEGIN 
 
    l_your_age := TRUNC(MONTHS_BETWEEN(SYSDATE,to_date(p_birth_date, 'MM/DD/YYYY')))/12;  
    return to_char(l_your_age); 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_calculate_age;    
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION chk_agelimit_for_admission( 
    p_limityear IN number, 
    p_birth_date IN varchar2)  
    RETURN boolean 
AS  
    l_scope logger_logs.scope%type := gc_scope_prefix || 'chk_agelimit_for_admission'; 
    l_params logger.tab_param; 
    l_your_age   NUMBER(3, 1);    
     
     
BEGIN 
 
    l_your_age := TRUNC(MONTHS_BETWEEN(SYSDATE,to_date(p_birth_date, 'MM/DD/YYYY')))/12;  
     
    if l_your_age >= p_limityear  THEN 
        return true; 
    else 
        return false; 
    end if; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END chk_agelimit_for_admission;    
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION password_compare( 
    p_password IN varchar2, 
    p_confirm_pwd IN varchar2)  
    RETURN boolean 
AS  
    l_scope logger_logs.scope%type := gc_scope_prefix || 'password_compare'; 
    l_params logger.tab_param; 
        
BEGIN 
   
    if p_password = p_confirm_pwd  THEN 
        return true; 
    else 
        return false; 
    end if; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END password_compare;    
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION compare_newandold_password( 
    p_username IN varchar2, 
    p_oldpassword IN varchar2)  
    RETURN boolean 
AS     
    l_scope logger_logs.scope%type := gc_scope_prefix || 'compare_newandold_password'; 
    l_params logger.tab_param; 
    l_oldpassword varchar2(1000);    
BEGIN 
   
    select password into l_oldpassword from users_mst where UPPER(USERNAME) = UPPER(p_username);  
     
    if p_oldpassword =  enc_dec.decrypt(hextoraw(l_oldpassword))  THEN 
        return true; 
    else 
        return false; 
    end if; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END compare_newandold_password;    
     
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_country_byid( 
    p_country_id IN number)  
    RETURN varchar2 
AS  
    l_country varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_country_byid'; 
    l_params logger.tab_param; 
BEGIN 
    select  country_name into l_country from COUNTRIES_MST where country_id = p_country_id;   
    return l_country; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_country_byid;      
 
------------------------------------------------------------------------------------------------------------     
 
FUNCTION get_state_byid( 
    p_state_id IN number)  
    RETURN varchar2 
AS  
    l_state_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_state_byid'; 
    l_params logger.tab_param; 
BEGIN 
    select state_name into l_state_name from STATE_MST where state_id = p_state_id;   
    return l_state_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_state_byid;      
     
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_employeename_byid( 
    p_employee_id IN number)  
    RETURN varchar2 
AS  
    l_employee_name varchar2(100); 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_employeename_byid'; 
    l_params logger.tab_param; 
BEGIN 
    select firstname||' '||middlename||' '||lastname into l_employee_name from employee_det where employee_id = p_employee_id;   
    return l_employee_name; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_employeename_byid;  
 
------------------------------------------------------------------------------------------------------------ 

FUNCTION get_empid_byusername(p_username IN varchar2, p_inst_id IN NUMBER)  RETURN number
AS  
    l_employee_id number; 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_empid_byusername'; 
    l_params logger.tab_param; 
BEGIN 
    SELECT EMPLOYEE_ID INTO l_employee_id 
    FROM EMPLOYEE_DET 
    WHERE USER_ID = APP_UTIL.get_useridfrom_username(p_username)
        AND INSTITUTE_ID = p_inst_id;
    
    return l_employee_id; 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_empid_byusername;  

------------------------------------------------------------------------------------------------------------ 

FUNCTION chk_valid_email( 
    p_email IN varchar2)  
    RETURN boolean 
 AS 
  
 cemailregexp constant varchar2(1000) := '[a-zA-Z0-9._%-]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}'; 
 l_scope logger_logs.scope%type := gc_scope_prefix || 'chk_valid_email'; 
 l_params logger.tab_param; 
begin 
     if regexp_like(p_email,cemailregexp,'i') then 
     return true; 
     else 
     return false; 
     end if; 
 
EXCEPTION 
    WHEN others THEN 
          logger.log_error('Unhandled Exception', l_scope, null, l_params); 
          raise;     
       
END chk_valid_email;  
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION chk_specialcharnotallow( 
    p_str IN varchar2)  
    RETURN boolean  
AS 
   v_special     VARCHAR2 (400)  := '+-*/?=)(/&%$§"'; 
   v_count       NUMBER          := 1; 
   v_character   VARCHAR2 (1000); 
   v_error       VARCHAR2 (4000); 
   l_scope logger_logs.scope%type := gc_scope_prefix || 'chk_specialcharnotallow'; 
   l_params logger.tab_param; 
BEGIN 
   FOR i IN 1 .. LENGTH (v_special) 
   LOOP 
      v_character := SUBSTR (v_special, v_count, 1); 
 
      IF INSTR (p_str, v_character) > 0 
      THEN 
         v_error := 
             v_error || 'The ' || v_character || ' character is not allowed.' || '</br>'; 
      END IF; 
 
      v_count := v_count + 1; 
   END LOOP; 
 
   IF v_error is null then 
        return true; 
   else 
        return false; 
   end if; 
EXCEPTION 
 WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;    
 
END chk_specialcharnotallow; 
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION chk_onlycharacterallow( 
    p_str IN varchar2)  
    RETURN boolean  
 AS 
 l_str_regexp constant varchar2(1000) := '^[[:alpha:]]+$'; 
 l_scope logger_logs.scope%type := gc_scope_prefix || 'chk_onlycharacterallow'; 
 l_params logger.tab_param; 
begin 
     if regexp_like(p_str,l_str_regexp,'i') then 
     return true; 
     else 
     return false; 
     end if; 
 
EXCEPTION 
    WHEN others THEN 
          logger.log_error('Unhandled Exception', l_scope, null, l_params); 
          raise;     
       
END chk_onlycharacterallow;  
 
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION chk_onlynumberallow( 
    p_str IN varchar2)  
    RETURN boolean  
 AS 
 l_str_regexp constant varchar2(1000) := '^[[:digit:]]+$'; 
 l_scope logger_logs.scope%type := gc_scope_prefix || 'chk_onlynumberallow'; 
 l_params logger.tab_param; 
begin 
     if regexp_like(p_str,l_str_regexp,'i') then 
     return true; 
     else 
     return false; 
     end if; 
 
EXCEPTION 
    WHEN others THEN 
          logger.log_error('Unhandled Exception', l_scope, null, l_params); 
          raise;     
       
END chk_onlynumberallow;   
 
------------------------------------------------------------------------------------------------------------ 
 
FUNCTION get_userid_fromname( 
    p_user_name in varchar2) 
    return number 
as 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_userid_fromname'; 
    l_params logger.tab_param; 
    l_userid number; 
begin 
        select user_id into l_userid from users_mst where upper(username)=upper(p_user_name); 
        return l_userid; 
 
EXCEPTION 
    WHEN others THEN 
          logger.log_error('Unhandled Exception', l_scope, null, l_params); 
          raise;    
end get_userid_fromname; 
 
 
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL PROCEDURE HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------------------------ 
 
PROCEDURE SEND_EMAIL( 
           p_to     IN varchar2, 
           p_from   IN varchar2, 
           p_subj   IN varchar2 default null) 
AS 
    l_id NUMBER; 
    l_INVOICECOPY  BLOB; 
    l_FILE_NAME    VARCHAR2(200); 
    l_MIME_TYPE    VARCHAR2(200); 
BEGIN 
    l_id := APEX_MAIL.SEND( 
        p_to        => p_to, 
        p_from      => p_from, 
        p_subj      => p_subj, 
        p_body      => 'Please review the attachment.', 
        p_body_html => '<b>Please</b> review the attachment'); 
 
/* SELECT INVOICECOPY,FILE_NAME,MIME_TYPE INTO l_INVOICECOPY,l_FILE_NAME,l_MIME_TYPE FROM  CLIENTINVOICES WHERE INVOICEID = 21; 
 
        APEX_MAIL.ADD_ATTACHMENT( 
            p_mail_id    => l_id, 
            p_attachment => l_INVOICECOPY, 
            p_filename   => l_FILE_NAME, 
            p_mime_type  => l_MIME_TYPE); */ 
   
END SEND_EMAIL; 
 
end OLD_APP_UTIL; 

/
