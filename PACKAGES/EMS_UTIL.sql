--------------------------------------------------------
--  DDL for Package EMS_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."EMS_UTIL" as

---------------------------------------------------------------------------------------------------------------------- 
------------------------==================This package contains code:=====================----------------------------
----------Function: Dynamic Navigation Menu, Get User Type ID----------
----------Deletion of Institute, Parents, Students, Employee----------
----------Library procedures for Issue, Return and Renew book----------
----------Uploading procedures from Collection to database----------
----------Assign Hostel Room----------
----------Assign Vehicle to Students----------
---------------------------------------------------------------------------------------------------------------------- 

function dynamic_nav_menu(
	p_app_user IN VARCHAR2,
	p_app_id IN NUMBER
)
RETURN VARCHAR2;

function get_usertypeid(
	p_usertypecode IN VARCHAR,
	p_inst_id IN NUMBER)
RETURN NUMBER;

procedure delete_institute(p_inst_id IN NUMBER);

procedure delete_parents(p_parent_id IN NUMBER);

procedure delete_students(p_stud_id IN NUMBER);

procedure delete_employee(p_emp_id IN NUMBER);

procedure issue_book(
    p_emp_id IN NUMBER, 
    p_stud_id IN NUMBER, 
    p_lib_id IN NUMBER, 
    p_issue_date IN DATE, 
    p_return_date IN DATE, 
    p_inst_id IN NUMBER, 
    p_acyear_id IN NUMBER
);

procedure return_book(
    p_selected_user IN VARCHAR2,
    p_lib_id IN NUMBER,
    p_stud_id IN NUMBER,
    p_book_id IN NUMBER,
    p_charge IN NUMBER,
    p_desc IN VARCHAR2,
    p_status IN VARCHAR2,
    p_findate IN DATE,
    p_emp_id IN NUMBER,
    p_empbook_id IN NUMBER,
    p_inst_id IN NUMBER,
    p_acyr_id IN NUMBER
);

procedure renew_book(
    p_selected_user IN VARCHAR2,
    p_lib_id IN NUMBER,
    p_stud_id IN NUMBER,
    p_book_id IN NUMBER,
    p_emp_id IN NUMBER,
    p_empbook_id IN NUMBER,
    p_issue_date IN DATE,
    p_return_date IN DATE,
    p_inst_id IN NUMBER,
    p_acyr_id IN NUMBER
);

procedure upload_attendance_to_db(
    p_inst_id IN NUMBER,
    p_acyear_id IN NUMBER,
    p_app_user IN VARCHAR2
);

procedure upload_subjects_to_db(
    p_aca_yr IN NUMBER, 
    p_inst_id IN NUMBER
);

procedure upload_admission_to_db(
    p_aca_yr IN NUMBER, 
    p_inst_id IN NUMBER
);

procedure upload_employees_to_db(
    p_inst_id IN NUMBER
);

procedure upload_ass_subjects_to_db (
    p_inst_id IN NUMBER,
    p_aca_yr IN NUMBER
);

procedure hostel_assign_room (
    p_hostel_id IN NUMBER, 
    p_room_id IN NUMBER, 
    p_stud_id IN VARCHAR2, 
    p_status IN VARCHAR2, 
    p_inst_id IN NUMBER,
    p_ac_yr IN NUMBER
);

procedure assign_vehicle(
    p_vehicle_id IN NUMBER, 
    p_trans_code IN VARCHAR2, 
    p_point_id IN NUMBER, 
    p_stud_id IN VARCHAR2, 
    p_inst_id IN NUMBER
);

procedure create_user_roles(
	p_inst_id IN NUMBER
);

END EMS_UTIL;

/
