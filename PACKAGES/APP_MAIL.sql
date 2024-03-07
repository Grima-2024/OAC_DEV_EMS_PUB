--------------------------------------------------------
--  DDL for Package APP_MAIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."APP_MAIL" as 
 
 
 
 
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
 
procedure test ( 
   p_arg1 in varchar2 default null, 
   p_arg2 in number   default null); 
    
PROCEDURE SENDHOLIDAYEMAIL(p_templateid  in number,p_sender IN varchar2,p_receiver IN varchar2,p_title IN varchar2,p_body IN clob); 
 
---------------------------------------------------------------------------------------------------------------------- 
----------------------------==================== ALL FUNCTIONS HERE  =========================------------------------- 
---------------------------------------------------------------------------------------------------------------------- 
 
 
function test_func ( 
    p_arg1 in number ) 
    return varchar2; 
     
function GETSENDERNAME(p_USERNAME IN VARCHAR2) RETURN VARCHAR2; 
 
function GETRECEIVERNAME(p_EMAILID IN VARCHAR2) RETURN VARCHAR2; 
 
function GETEMAILTEMPLATE(p_TEMPLATE_ID NUMBER) RETURN CLOB; 
 
 
 
 
end; 

/
