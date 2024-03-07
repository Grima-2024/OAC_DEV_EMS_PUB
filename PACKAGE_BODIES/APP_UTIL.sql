--------------------------------------------------------
--  DDL for Package Body APP_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."APP_UTIL" is 

---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL GLOBAL DECLARATION HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.'; 
 
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL FUNCTION HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
 
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

FUNCTION get_usertypeid_fromusername(p_username IN VARCHAR2, p_inst_id IN NUMBER)  
RETURN NUMBER
AS   
    l_utypeid NUMBER;
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_rolenamefrom_id'; 
    l_params logger.tab_param; 
BEGIN 
    select user_type_id into l_utypeid 
    from USERS_MST 
    where LOWER(USERNAME) = LOWER(p_username) 
        and INSTUTUTE_ID = p_inst_id;  

    return l_utypeid; 
 
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
END get_usertypeid_fromusername;

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
 
FUNCTION get_calculate_age( 
    p_birth_date IN varchar2)  
    RETURN varchar2 
AS  
    l_scope logger_logs.scope%type := gc_scope_prefix || 'get_calculate_age'; 
    l_params logger.tab_param; 
    l_your_age   NUMBER(3, 1);    
BEGIN 
    l_your_age := ROUND(TRUNC(MONTHS_BETWEEN(SYSDATE,to_date(p_birth_date, 'MM/DD/YYYY')))/12,0);  
    return to_char(l_your_age); 
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;     
     
END get_calculate_age;    
 
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
 
end APP_UTIL;

/
