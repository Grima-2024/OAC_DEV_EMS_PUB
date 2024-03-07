--------------------------------------------------------
--  DDL for Package EMS_PROMOTION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."EMS_PROMOTION" as

---------------------------------------------------------------------------------------------------------------------- 
------=====This package contains code for Class and Subject Settings and Promotion of student=======-------
---------Class Settings : (Medium,Std,Sem and Div) to carry forward in new Academic Session-------------
---------------Subject Settings : to carry forward old Subjects in new Academic Session-----------------
-----------------------Promote Student : to next Class in new Academic Session--------------------------
---------------------------------------------------------------------------------------------------------------------- 

procedure class_settings(
    p_selected IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_curr_acyr_id IN NUMBER, 
    p_new_acyr_id IN NUMBER
);

procedure subject_settings(
    p_selected IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_curr_acyr_id IN NUMBER, 
    p_new_acyr_id IN NUMBER
);
    
procedure promote_students(
    p_stud_id IN NUMBER,
    p_old_med IN NUMBER,
    p_old_std IN NUMBER,
    p_new_std IN NUMBER,
    p_new_acyr_id IN NUMBER,
    p_inst_id IN NUMBER
);

END EMS_PROMOTION;

/
