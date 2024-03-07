--------------------------------------------------------
--  DDL for Package Body APP_MAIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."APP_MAIL" is 
 
 
 
      /********************************************************************************* +/ 
     //    Package Contain utility function for entire application  function  
    //     CREATED By : Mayur Vaghasiya   CREATED ON: 
   //      UPDATED By : Mayur Vaghasiya   UPDATED ON: 
  /********************************************************************************/ 
   
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL GLOBAL DECLARATION HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
 
 
 
 
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL PROCEDURES HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
 
 
 
 
 
 
procedure TEST( P_ARG1 IN VARCHAR2 
               ,P_ARG2 IN NUMBER 
) 
as 
begin 
 null; /* insert procedure code */ 
end TEST; 
 
---------------------------------------------------------------------------------------------------------------------- 
 
PROCEDURE SENDHOLIDAYEMAIL(p_templateid  in number,p_sender IN varchar2,p_receiver IN varchar2,p_title IN varchar2,p_body IN clob) 
as  
v_template clob; 
BEGIN 
    --GET TEMPLATE 
    v_template:=GETEMAILTEMPLATE(p_templateid); 
 
    v_template:=REPLACE(v_template,'#RECEIVER#',p_receiver); 
    v_template:=REPLACE(v_template,'#MAILBODY#',p_body); 
    v_template:=REPLACE(v_template,'#SENDER#',p_sender); 
 
    htp.p(v_template); 
 
END; 
 
 
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL FUNCTIONS HERE  =========================------------------------ 
---------------------------------------------------------------------------------------------------------------------- 
 
 
function TEST_FUNC(P_ARG1 IN NUMBER 
) return VARCHAR2 
 
as 
begin 
 null; /* insert function code */ 
end TEST_FUNC; 
 
----------------------------------------------------------------------------------------------------------------- 
 
function GETSENDERNAME(p_USERNAME IN VARCHAR2) RETURN VARCHAR2 
as 
    l_fullname varchar2(500):=p_USERNAME; 
begin 
    select FIRSTNAME||' '||LASTNAME into l_fullname FROM  USERS_MST WHERE USERNAME=p_USERNAME;  
    return l_fullname; 
     
     
    EXCEPTION WHEN OTHERS THEN 
          return p_USERNAME; 
     
end GETSENDERNAME; 
 
----------------------------------------------------------------------------------------------------------------- 
 
function GETRECEIVERNAME(p_EMAILID IN VARCHAR2) RETURN VARCHAR2 
as 
begin 
 null; /* insert function code */ 
end GETRECEIVERNAME; 
 
----------------------------------------------------------------------------------------------------------------- 
 
function GETEMAILTEMPLATE(p_TEMPLATE_ID NUMBER) RETURN CLOB 
as 
v_template clob; 
begin 
 
    SELECT TEMPLATE_BODY INTO v_template FROM EMAIL_TEMPLATE where ET_ID=p_TEMPLATE_ID; 
    return v_template; 
 
    EXCEPTION WHEN OTHERS THEN 
    RETURN NULL; 
 
end GETEMAILTEMPLATE; 
 
----------------------------------------------------------------------------------------------------------------- 
 
 
 
end "APP_MAIL"; 

/
