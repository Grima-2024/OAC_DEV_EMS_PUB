--------------------------------------------------------
--  DDL for Package EMS_UPLOAD_FILE_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."EMS_UPLOAD_FILE_PKG" as

---------------------------------------------------------------------------------------------------------------------- 
---------=====This package contains Uploading Procedures(from xlsx file to table) for various facilities=====---------
---------------------------------------------------------------------------------------------------------------------- 

procedure get_attendance_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER);

procedure get_admission_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER);

procedure get_questionbank_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER);

procedure get_subjects_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER);

procedure get_employee_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER);

procedure get_ass_subjects_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER);

function GET_STUD_ID (p_stud_f IN VARCHAR2, p_stud_m IN VARCHAR2, p_stud_l IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
    return NUMBER;
    
function GET_MED_ID (p_medium in VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
    return NUMBER;

function GET_STD_ID (p_std in VARCHAR2, p_med IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
    return NUMBER;

function GET_SEM_ID (p_sem in VARCHAR2, p_std IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
    return NUMBER;

function GET_DIV_ID (p_div in VARCHAR2, p_std in NUMBER, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
    return NUMBER;

function GET_SUB_ID (p_sub in VARCHAR2, p_std in NUMBER, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
    return NUMBER;

function GET_TIME_ID (p_from in VARCHAR2, p_to in VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
    return NUMBER;

function GET_COUNTRY_ID(p_country IN VARCHAR2) 
    return NUMBER;

function GET_STATE_ID(p_state IN VARCHAR2, p_count_id IN VARCHAR2) 
    return NUMBER;
    
end EMS_UPLOAD_FILE_PKG;

/
