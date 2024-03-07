--------------------------------------------------------
--  DDL for Package EMS_EVENT_MSG_MAIL_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."EMS_EVENT_MSG_MAIL_UTIL" as

---------------------------------------------------------------------------------------------------------------------- 
--------------================This package contains Event, Memo and Message related code=================-------------
----------Event : Create and Delete Event--------------------
----------Memo : Account, Leave and Production Memo----------
----------Mail : Internal Mail between all users-------------
---------------------------------------------------------------------------------------------------------------------- 

procedure create_event(
    p_repeat_on IN CHAR,
    p_start_date IN VARCHAR2,
    p_end_date IN VARCHAR2,
    p_event_type IN NUMBER,
    p_event_details IN VARCHAR2,
    p_inst_id IN NUMBER,
    p_acyr_id IN NUMBER
);

procedure delete_event(
    p_repeat_on IN CHAR, 
    p_event_details IN VARCHAR2
);

procedure leave_memo(
    p_memo_type IN CHAR, 
    p_memo_sub IN VARCHAR2, 
    p_memo_matter IN VARCHAR2, 
    p_appuser IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER
);

procedure accounts_memo(
    p_memo_type IN CHAR, 
    p_memo_sub IN VARCHAR2, 
    p_memo_matter IN VARCHAR2, 
    p_appuser IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER
);

procedure production_memo(
    p_memo_rec IN CHAR, 
    p_memo_sub IN VARCHAR2, 
    p_memo_matter IN VARCHAR2, 
    p_user_type IN VARCHAR2,
    p_user_names IN VARCHAR2,
    p_appuser IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER
);

procedure production_memo_emp(
    p_memo_rec IN CHAR, 
    p_memo_sub IN VARCHAR2, 
    p_memo_matter IN VARCHAR2, 
    p_user_type IN VARCHAR2,
    p_user_names IN VARCHAR2,
    p_appuser IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER
);

procedure send_internal_mail(
    p_mail_rec IN CHAR, 
    p_mail_sub IN VARCHAR2, 
    p_mail_matter IN VARCHAR2, 
    p_med_id IN NUMBER,
    p_std_id IN NUMBER,
    p_sem_id IN NUMBER,
    p_div_id IN NUMBER,
    p_dept_id IN NUMBER,
    p_user_type IN VARCHAR2,
    p_appuser IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER
);

END EMS_EVENT_MSG_MAIL_UTIL;

/
