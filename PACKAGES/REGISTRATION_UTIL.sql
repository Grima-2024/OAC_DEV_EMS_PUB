--------------------------------------------------------
--  DDL for Package REGISTRATION_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."REGISTRATION_UTIL" as 
 
 
 
 
   type t_file_data is record ( 
          blob_content       apex_application_files.blob_content%type 
        , mime_type          apex_application_files.mime_type%type 
        , title              apex_application_files.title%type 
        , last_updated       apex_application_files.last_updated%type 
        , file_charset       apex_application_files.file_charset%type 
    );  
     
     
 
 
procedure test ( 
   p_arg1 in varchar2 default null, 
   p_arg2 in number   default null); 
 
function test_func ( 
    p_arg1 in number ) 
    return varchar2; 
     
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
	 p_admission_status in VARCHAR2 default 'P'); 
 
PROCEDURE  INS_USERINFOFROM_PROFILE  ( 
   p_primarykeyid in number , 
   p_username in varchar2, 
   p_password in varchar2, 
   p_user_type in varchar2, 
   p_instituteid in number); 
    
PROCEDURE  UPD_USERINFOFROM_PROFILE  ( 
   p_user_id in number , 
   p_username in varchar2, 
   p_password in varchar2);    
 
     
end; 

/
