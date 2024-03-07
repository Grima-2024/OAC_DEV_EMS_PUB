--------------------------------------------------------
--  DDL for Package Body REGISTRATION_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."REGISTRATION_UTIL" is 
 
gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.'; 
 
 
 
function TEST_FUNC(       P_ARG1 IN NUMBER 
) return VARCHAR2 
 
as 
begin 
 null; /* insert function code */ 
end TEST_FUNC; 
 
procedure TEST(       P_ARG1 IN VARCHAR2 
      ,P_ARG2 IN NUMBER 
) 
as 
begin 
 null; /* insert procedure code */ 
end TEST; 
 
PROCEDURE ins_stud_admission( 
     p_adm_appl_code    in VARCHAR2,  
	 p_firstname        in VARCHAR2,  
	 p_middlename       in VARCHAR2,  
	 p_lastname         in VARCHAR2,  
	 p_date_of_birth    in DATE ,  
	 p_age              in VARCHAR2,  
	 p_gender           in VARCHAR2,  
	 p_category         in VARCHAR2,  
	 p_mother_tongue    in VARCHAR2,  
	 p_nationality      in VARCHAR2,  
	 p_religion         in VARCHAR2,  
	 p_fathername       in VARCHAR2,  
	 p_home_address     in VARCHAR2,  
	 p_pincode          in NUMBER,  
	 p_city             in VARCHAR2,  
	 p_state_id         in NUMBER,  
	 p_country_id       in NUMBER,  
	 p_tel_no           in VARCHAR2,  
	 p_mobile_no        in VARCHAR2,  
	 p_office_address   in VARCHAR2,  
	 p_office_phone     in VARCHAR2,  
	 p_extension_no     in VARCHAR2,  
	 p_office_mobile    in VARCHAR2,  
	 p_occupation       in VARCHAR2,  
	 p_position         in VARCHAR2,  
	 p_med_id           in NUMBER,  
	 p_std_id           in NUMBER,  
	 p_photo_title      in VARCHAR2,  
	 p_photo            in BLOB,  
	 p_pmimetype        in VARCHAR2,  
	 p_pcharset         in VARCHAR2,  
	 p_plastupdate      in VARCHAR2,  
	 p_stsign_title     in VARCHAR2,  
	 p_student_sign     in BLOB,  
	 p_smimetype        in VARCHAR2,  
	 p_scharset         in VARCHAR2,  
	 p_splastupdate     in VARCHAR2,  
	 p_prsign_title     in VARCHAR2,  
	 p_parent_sign      in BLOB,  
	 p_psmimetype       in VARCHAR2,  
	 p_pscharset        in VARCHAR2,  
	 p_pslastupdate     in VARCHAR2,  
	 p_institute_id     in NUMBER,  
	 p_admission_status in VARCHAR2) 
      
   /* */
as 
begin 
 --null; /* insert procedure code */ 
 INSERT INTO  ADMISSION_APPLICATION  
     ( 
       adm_appl_code    ,  
	   firstname        ,  
	   middlename       ,  
	   lastname         ,  
	   date_of_birth    ,  
	   age              ,  
	   gender           ,  
	   category         ,  
	   mother_tongue    ,  
	   nationality      ,  
	   religion         ,  
	   fathername       ,  
	   home_address     ,  
	   pincode          ,  
	   city             ,  
	   state_id         ,  
	   country_id       ,  
	   tel_no           ,  
	   mobile_no        ,  
	   office_address   ,  
	   office_phone     ,  
	   extension_no     ,  
	   office_mobile    ,  
	   occupation       ,  
	   position         ,  
	   med_id           ,  
	   std_id           ,  
	   photo_title      ,  
	   photo            ,  
	   pmimetype        ,  
	   pcharset         ,  
	   plastupdate      ,  
	   stsign_title     ,  
	   student_sign     ,  
	   smimetype        ,  
	   scharset         ,  
	   splastupdate     ,  
	   prsign_title     ,  
	   parent_sign      ,  
	   psmimetype       ,  
	   pscharset        ,  
	   pslastupdate     ,  
	   institute_id     ,  
	   admission_status  
     )      
     values( 
        p_adm_appl_code    ,  
	 p_firstname        ,  
	 p_middlename       ,  
	 p_lastname         ,  
	 p_date_of_birth    ,  
	 p_age              ,  
	 p_gender           ,  
	 p_category         ,  
	 p_mother_tongue    ,  
	 p_nationality      ,  
	 p_religion         ,  
	 p_fathername       ,  
	 p_home_address     ,  
	 p_pincode          ,  
	 p_city             ,  
	 p_state_id         ,  
	 p_country_id       ,  
	 p_tel_no           ,  
	 p_mobile_no        ,  
	 p_office_address   ,  
	 p_office_phone     ,  
	 p_extension_no     ,  
	 p_office_mobile    ,  
	 p_occupation       ,  
	 p_position         ,  
	 p_med_id           ,  
	 p_std_id           ,  
	 p_photo_title      ,  
	 p_photo            ,  
	 p_pmimetype        ,  
	 p_pcharset         ,  
	 p_plastupdate      ,  
	 p_stsign_title     ,  
	 p_student_sign     ,  
	 p_smimetype        ,  
	 p_scharset         ,  
	 p_splastupdate     ,  
	 p_prsign_title     ,  
	 p_parent_sign      ,  
	 p_psmimetype       ,  
	 p_pscharset        ,  
	 p_pslastupdate     ,  
	 p_institute_id     ,  
	 p_admission_status  
     );
end ins_stud_admission; 
 
 
PROCEDURE  INS_USERINFOFROM_PROFILE  ( 
   p_primarykeyid  in number , 
   p_username      in varchar2, 
   p_password      in varchar2, 
   p_user_type     in varchar2, 
   p_instituteid   in number ) 
AS 
    l_userrole_id number;    
    l_scope logger_logs.scope%type := gc_scope_prefix || 'INS_USERINFOFROM_PROFILE'; 
    l_params logger.tab_param; 
    l_user_id number; 
    l_parent_id number; 
BEGIN 
    
    select USER_TYPE_ID into l_userrole_id from USERS_TYPE_MST where trim(USER_TYPE_CODE) = trim(p_user_type); 
     
    insert into USERS_MST ( 
        username          , 
        password          , 
        ACCOUNT_STATUS    , 
        USER_TYPE_ID      , 
        INSTUTUTE_ID)  
        values(p_username                    , 
               enc_dec.encrypt(p_password)   , 
               1                             , 
               l_userrole_id                 , 
               p_instituteid); 
 
    l_user_id := app_util.get_userid_fromname(p_username);  
     
    IF  p_user_type = 'PER' THEN 
        update PARENTS_DET set user_id=l_user_id where PARENTS_ID = p_primarykeyid; 
    ELSIF p_user_type = 'STD' THEN 
        update STUDENTS_DET set user_id=l_user_id where STUDENT_ID = p_primarykeyid;   
    ELSIF p_user_type = 'TEC' THEN 
        update EMPLOYEE_DET set user_id=l_user_id where EMPLOYEE_ID = p_primarykeyid;     
    END IF; 
     
     
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;  
 
 
END INS_USERINFOFROM_PROFILE; 
 
 
PROCEDURE  UPD_USERINFOFROM_PROFILE  ( 
   p_user_id in number , 
   p_username in varchar2, 
   p_password in varchar2) 
AS 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'UPD_USERINFOFROM_PROFILE'; 
    l_params logger.tab_param; 
BEGIN 
   UPDATE USERS_MST set username=p_username,password=enc_dec.encrypt(p_password) WHERE user_id =p_user_id; 
 
EXCEPTION 
    WHEN others THEN 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise;  
 
END UPD_USERINFOFROM_PROFILE; 
 
end REGISTRATION_UTIL; 

/
