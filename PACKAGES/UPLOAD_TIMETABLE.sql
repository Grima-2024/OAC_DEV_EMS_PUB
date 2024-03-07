--------------------------------------------------------
--  DDL for Package UPLOAD_TIMETABLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."UPLOAD_TIMETABLE" as

procedure get_data_to_collection(P_FILE IN VARCHAR2);

FUNCTION GET_EMP_ID(p_fnm IN VARCHAR2, p_lnm IN VARCHAR2) 
RETURN NUMBER ;

FUNCTION GET_MED_ID(p_medium IN VARCHAR2) 
RETURN NUMBER;

FUNCTION GET_STD_ID(p_std IN VARCHAR2, p_med IN VARCHAR2) 
RETURN NUMBER;

FUNCTION GET_SEM_ID(p_sem IN VARCHAR2,p_std IN VARCHAR2) 
RETURN NUMBER;

FUNCTION GET_DIV_ID(p_div IN VARCHAR2,p_std IN NUMBER) 
RETURN NUMBER;

FUNCTION GET_SUB_ID(p_sub IN VARCHAR2,p_std IN NUMBER) 
RETURN NUMBER;

end;

/
