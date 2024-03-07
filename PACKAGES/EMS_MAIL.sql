--------------------------------------------------------
--  DDL for Package EMS_MAIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."EMS_MAIL" as

---------------------------------------------------------------------------------------------------------------------- 
---------------================This package contains code for sending Email to users=================-----------------
---------------------------------------------------------------------------------------------------------------------- 

procedure registration_mail (
   p_appl_code in number,
   p_institute_id in number,
   p_stud_id in number,
   p_acyr_id in number);

procedure event_mail(
    p_institute_id in number,
    p_event_id number);

procedure school_intro_mail(
    p_institute_id in number, 
    p_stud_id in number,
    p_acyr_id in number);

procedure internal_mail(
    p_institute_id in number,
    p_email_id in number);

procedure test_assigned_mail (
    p_test in varchar2,
    p_std_id in number,
    p_acyr_id in number);

procedure test_results_mail (
    p_test_id in number, 
    p_user_id in number,
    p_acyr_id in number
);

procedure fees_mail (
    p_stud_id in number, 
    p_fees_type in number, 
    p_inst in number,
    p_acyr_id in number
);

end EMS_MAIL;

/
