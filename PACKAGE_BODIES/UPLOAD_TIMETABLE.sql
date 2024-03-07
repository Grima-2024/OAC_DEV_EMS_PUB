--------------------------------------------------------
--  DDL for Package Body UPLOAD_TIMETABLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."UPLOAD_TIMETABLE" as

procedure get_data_to_collection(P_FILE IN VARCHAR2) as
Begin
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(
        p_collection_name => 'STORE_TIMETBL' );

        for i in (with lst1 as (select * from apex_application_temp_files where name = P_FILE)
            SELECT line_number, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, 
                col011, col012, col013,
                GET_MED_ID(col001) AS MED_ID,
                GET_STD_ID(col002,GET_MED_ID(col001)) AS STD_ID,
                GET_SEM_ID(col003,GET_STD_ID(col002,GET_MED_ID(col001))) AS SEM_ID,
                GET_DIV_ID(col004,GET_STD_ID(col002,GET_MED_ID(col001))) AS DIV_ID,
                GET_SUB_ID(col005,GET_STD_ID(col002,GET_MED_ID(col001))) AS SUB_ID,
                GET_EMP_ID(col007,col008) AS EMP_ID
                FROM lst1, TABLE(
                         APEX_DATA_PARSER.parse(
                           p_content                     => lst1.blob_content,
                            p_add_headers_row             => 'Y',
                            p_max_rows                    => 500,
                            p_file_name                   => lst1.filename,
                            p_skip_rows                   => 1 ) 
                       )x 
                       order by line_number )
       loop
                APEX_COLLECTION.ADD_MEMBER(
                p_collection_name => 'STORE_TIMETBL',
                p_c001            => i.col001,
                p_c002            => i.col002,
                p_c003            => i.col003,
                p_c004            => i.col004,
                p_c005            => i.col005,
                p_c006            => i.col006,
                p_c007            => i.col007,
                p_c008            => i.col008,
                p_c009            => i.col009,
                p_c010            => i.MED_ID,
                p_c011            => i.STD_ID,
                p_c012            => i.SEM_ID,   
                p_c013            => i.DIV_ID,
                p_c014            => i.SUB_ID,
                p_c015            => i.EMP_ID
                );
    end loop;
    exception when others then
    apex_debug.error('Error inside Collection %s', sqlerrm);
end;

-----------------------------------EMPLOYEE ID--------------------------------------
FUNCTION GET_EMP_ID(p_fnm IN VARCHAR2, p_lnm IN VARCHAR2) 
RETURN NUMBER
IS
    emp_id NUMBER;
BEGIN  
    SELECT EMPLOYEE_ID into emp_id FROM EMPLOYEE_DET 
    WHERE LOWER(FIRSTNAME) = LOWER(p_fnm)
        AND LOWER(LASTNAME) = LOWER(p_lnm)
        AND INSTITUTE_ID = V('APP_INSTITUTE');
    RETURN(emp_id);
END;

-----------------------------------MEDIUM--------------------------------------
FUNCTION GET_MED_ID(p_medium IN VARCHAR2) 
RETURN NUMBER 
IS
    medium_id NUMBER;
BEGIN  
    SELECT MED_ID into medium_id FROM MEDIUM_MST 
    WHERE LOWER(MEDIUM_NAME) = LOWER(p_medium) 
        AND INSTITUTE_ID = V('APP_INSTITUTE')
        AND AC_YEAR_ID = V('APP_ACADEMIC');
    RETURN(medium_id);
END;

----------------------------------STANDARD---------------------------------
FUNCTION GET_STD_ID(p_std IN VARCHAR2, p_med IN VARCHAR2) 
RETURN NUMBER 
IS
    stand_id NUMBER;
BEGIN  
    SELECT STD_ID into stand_id FROM STANDARD_MST 
    WHERE LOWER(STD_NAME) = LOWER(p_std)
        AND MED_ID = p_med
         AND INSTITUTE_ID = V('APP_INSTITUTE')
        AND AC_YEAR_ID = V('APP_ACADEMIC');
    RETURN(stand_id);
END;

--------------------------------SEMESTER------------------------------------
FUNCTION GET_SEM_ID(p_sem IN VARCHAR2,p_std IN VARCHAR2) 
RETURN NUMBER 
IS
    semt_id NUMBER;
BEGIN  
    SELECT SEM_ID into semt_id FROM SEMESTER_MST 
    WHERE LOWER(SEM_NAME) = LOWER(p_sem) 
        AND STD_ID = p_std
        AND INSTITUTE_ID = V('APP_INSTITUTE')
        AND AC_YEAR_ID = V('APP_ACADEMIC');
    RETURN(semt_id);
END;

--------------------------------DIVISION------------------------------------
FUNCTION GET_DIV_ID(p_div IN VARCHAR2,p_std IN NUMBER) 
RETURN NUMBER 
IS
    divi_id NUMBER;
BEGIN  
    SELECT DIVISION_ID into divi_id FROM DIVISION_MST 
    WHERE LOWER(DIV_NAME) = LOWER(p_div) 
        AND STD_ID = p_std
        AND INSTITUTE_ID = V('APP_INSTITUTE')
        AND AC_YEAR_ID = V('APP_ACADEMIC');
    RETURN(divi_id);
END;

---------------------------------SUBJECT-----------------------------------
FUNCTION GET_SUB_ID(p_sub IN VARCHAR2,p_std IN NUMBER) 
RETURN NUMBER 
IS
    subj_id NUMBER;
BEGIN  
    SELECT SUB_ID into subj_id FROM SUBJECT_MST 
    WHERE LOWER(SUBJECT_NAME) = LOWER(p_sub) 
        AND STD_ID = p_std
        AND INSTITUTE_ID = V('APP_INSTITUTE')
        AND AC_YEAR_ID = V('APP_ACADEMIC');
    RETURN(subj_id);
END;

END UPLOAD_TIMETABLE;

/
