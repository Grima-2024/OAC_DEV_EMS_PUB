--------------------------------------------------------
--  DDL for Package EMS_MODULE_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."EMS_MODULE_UTIL" as

---------------------------------------------------------------------------------------------------------------------- 
------------------------==================This package contains code:=====================----------------------------
--1) Function that will return query for Dynamic Navigation Menu.
--2) Procedure for Assigning all the module to Institution at the time of Institution Registration.
--3) Choosing of Module from Assigned onces (i.e from above procedure)
--4) Edit Modules after assignment.
---------------------------------------------------------------------------------------------------------------------- 

function dynamic_nav_menu(
	p_app_user IN VARCHAR2,
	p_app_id IN NUMBER
)
RETURN VARCHAR2;

procedure assign_all_modules(
	p_inst_id IN NUMBER);

procedure choose_modules(
	p_start_date IN VARCHAR2,
	p_end_date IN VARCHAR2,
	p_admin_mod IN VARCHAR2,
	p_emp_mod IN VARCHAR2,
	p_par_mod IN VARCHAR2,
	p_stud_mod IN VARCHAR2,
	p_inst_id IN NUMBER);

procedure edit_modules(
	p_admin_mod IN VARCHAR2,
	p_emp_mod IN VARCHAR2,
	p_par_mod IN VARCHAR2,
	p_stud_mod IN VARCHAR2,
	p_inst_id IN NUMBER);

END EMS_MODULE_UTIL;

/
