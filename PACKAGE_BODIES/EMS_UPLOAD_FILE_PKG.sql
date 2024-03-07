--------------------------------------------------------
--  DDL for Package Body EMS_UPLOAD_FILE_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."EMS_UPLOAD_FILE_PKG" as 
   
--------------------------------------------------UPLOAD ATTENDANCE----------------------------------------------------------
procedure get_attendance_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) as
Begin
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(
        p_collection_name => 'STORE_FILE' );

        for i in (with lst1 as (select * from apex_application_temp_files where name = P_FILE)
            SELECT line_number, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013, col014, col015,
                EMS_UPLOAD_FILE_PKG.GET_STUD_ID(col001, col002, col003, p_inst_id, p_acyr_id) AS STUD_ID,
                EMS_UPLOAD_FILE_PKG.GET_MED_ID(col007, p_inst_id, p_acyr_id) AS MED_ID,
                EMS_UPLOAD_FILE_PKG.GET_STD_ID(col008,EMS_UPLOAD_FILE_PKG.GET_MED_ID(col007, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS STD_ID,
                EMS_UPLOAD_FILE_PKG.GET_SEM_ID(col009,GET_STD_ID(col008,GET_MED_ID(col007, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS SEM_ID,
                EMS_UPLOAD_FILE_PKG.GET_DIV_ID(col010,EMS_UPLOAD_FILE_PKG.GET_STD_ID(col008,GET_MED_ID(col007, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS DIV_ID,
                EMS_UPLOAD_FILE_PKG.GET_SUB_ID(col011,EMS_UPLOAD_FILE_PKG.GET_STD_ID(col008,GET_MED_ID(col007, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS SUB_ID,
                EMS_UPLOAD_FILE_PKG.GET_TIME_ID(col012, col013, p_inst_id, p_acyr_id) as TIME_ID
                FROM lst1, TABLE(
                         APEX_DATA_PARSER.parse(
                           p_content                     => lst1.blob_content,
                            p_add_headers_row             => 'Y',
                            p_max_rows                    => 500,
                            p_file_name                   => lst1.filename,
                            p_skip_rows                   => 1 ) 
                       )x 
                       --where x.col002 is not null or x.col003 is not null or x.col004 is not null or x.col005 is not null or x.col006 is not null 
                       order by line_number)
       loop
                APEX_COLLECTION.ADD_MEMBER(
                p_collection_name => 'STORE_FILE',
                p_c001            => i.col001,
                p_c002            => i.col002,
                p_c003            => i.col003,
                p_c004            => i.col004,
                p_c005            => i.col005,
                p_c006            => i.col006,
                p_c007            => i.col007,
                p_c008            => i.col008,
                p_c009            => i.col009,
                p_c010            => i.col010,
                p_c011            => i.col011,
                p_c012            => i.col012,
                p_c013            => i.col013,
                p_c014            => i.STUD_ID,
                p_c015            => i.MED_ID,
                p_c016            => i.STD_ID,
                p_c017            => i.SEM_ID,   
                p_c018            => i.DIV_ID,
                p_c019            => i.SUB_ID,
                p_c020            => i.TIME_ID
                );
    end loop;

    exception when others then logger.log_error('Error while parsing data to Collection : STORE_FILE');
    --apex_debug.error('Error inside Collection %s', sqlerrm);
end ;

--------------------------------------------------UPLOAD ADMISSION----------------------------------------------------------
procedure get_admission_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
AS
Begin
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(
        p_collection_name => 'STORE_ADMISSION' );

        for i in (with file1 as (select * from apex_application_temp_files where name = P_FILE)
            SELECT line_number, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013,
                    col014, col015, col016, col017, col018, col019, col020, col021, col022, col023, col024, col025, col026, col027, col028, col029, col030, 
                    col031, col032, col033, col034, col035, col036, col037, col038, col039, col040, 
                    col041, col042, col043, col044, col045, col046, col047, col048, col049, col050, 
                EMS_UPLOAD_FILE_PKG.GET_MED_ID(col041, p_inst_id, p_acyr_id) AS MED_ID,
                EMS_UPLOAD_FILE_PKG.GET_STD_ID(col042, EMS_UPLOAD_FILE_PKG.GET_MED_ID(col041, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS STD_ID,
                EMS_UPLOAD_FILE_PKG.GET_SEM_ID(col043,GET_STD_ID(col042,GET_MED_ID(col041, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS SEM_ID,
                EMS_UPLOAD_FILE_PKG.GET_DIV_ID(col044,GET_STD_ID(col042,GET_MED_ID(col041, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS DIV_ID,
                EMS_UPLOAD_FILE_PKG.GET_STATE_ID(col033,EMS_UPLOAD_FILE_PKG.GET_COUNTRY_ID(col032)) AS STATE_ID,
                EMS_UPLOAD_FILE_PKG.GET_COUNTRY_ID(col032) AS COUNTRY_ID,
                EMS_UPLOAD_FILE_PKG.GET_STATE_ID(col038,EMS_UPLOAD_FILE_PKG.GET_COUNTRY_ID(col037)) AS TEMP_STATE_ID,
                EMS_UPLOAD_FILE_PKG.GET_COUNTRY_ID(col037) AS TEMP_COUNTRY_ID
                FROM file1, TABLE(
                        APEX_DATA_PARSER.parse(
                            p_content                     => file1.blob_content,
                            p_add_headers_row             => 'Y',
                            p_max_rows                    => 500,
                            p_file_name                   => file1.filename,
                            p_skip_rows                   => 2 ) 
                       )x 
                       --where x.col002 is not null or x.col003 is not null or x.col004 is not null or x.col005 is not null or x.col006 is not null 
                       order by line_number )
       loop
                APEX_COLLECTION.ADD_MEMBER(
                p_collection_name => 'STORE_ADMISSION',
                p_c001            => i.col001,
                p_c002            => i.col002,
                p_c003            => i.col003,
                p_c004            => i.col004,
                p_c005            => i.col005,
                p_c006            => i.col006,--TO_DATE(i.col006,'YYYY/MM/DD'),
                p_c007            => i.col007,
                p_c008            => i.col008,
                p_c009            => i.col009,
                p_c010            => i.col010,
                p_c011            => i.col011,
                p_c012            => i.col012,
                p_c013            => i.col013,
                p_c014            => i.col014,
                p_c015            => i.col015,
                p_c016            => i.col016,
                p_c017            => i.col017,   
                p_c018            => i.col018,
                p_c019            => i.col019,
                p_c020            => i.col020,
                p_c021            => i.col021,
                p_c022            => i.col022,
                p_c023            => i.col023,
                p_c024            => i.col024,
                p_c025            => i.col025,
                p_c026            => i.col026,
                p_c027            => i.col027,   
                p_c028            => i.col028,
                p_c029            => i.col029,
                p_c030            => i.col030,
                p_c031            => i.col031,
                p_c032            => i.col032,
                p_c033            => i.col033,
                p_c034            => i.col034,
                p_c035            => i.col035,
                p_c036            => i.col036,
                p_c037            => i.col037,   
                p_c038            => i.col038,
                p_c039            => i.col039,
                p_c040            => i.col040,
                p_c041            => i.col041,
                p_c042            => i.col042,
                p_c043            => i.col043,
                p_c044            => i.col044,
                p_c045            => i.col045,
                p_c046            => i.col046,
                p_c047            => i.col047,
                p_c048            => i.TEMP_COUNTRY_ID,
                p_c049            => i.SEM_ID,
                p_c050            => I.DIV_ID,
                p_n001            => i.MED_ID,
                p_n002            => i.STD_ID,
                p_n003            => i.STATE_ID,
                p_n004            => i.COUNTRY_ID,
                p_n005            => i.TEMP_STATE_ID
                );
    end loop;
    exception when others then logger.log_error('Error while parsing data to Collection : STORE_ADMISSION');
    --apex_debug.error('Error inside Collection %s', sqlerrm);
end ;

-------------------------------------------UPLOAD QUESTION BANK-------------------------------------------

procedure get_questionbank_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER)
is 
BEGIN
     APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(
        p_collection_name => 'STORE_QUESTION_BANK');

        for i in (with QB as (select * from apex_application_temp_files where name = P_FILE)
            SELECT line_number, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013,
                    col014, col015, col016, col017, col018,
                    EMS_UPLOAD_FILE_PKG.GET_MED_ID(col012, p_inst_id, p_acyr_id) AS MED_ID,
                    EMS_UPLOAD_FILE_PKG.GET_STD_ID(col013, EMS_UPLOAD_FILE_PKG.GET_MED_ID(col012, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS STD_ID,
                    EMS_UPLOAD_FILE_PKG.GET_SEM_ID(col014,GET_STD_ID(col013,GET_MED_ID(col012, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS SEM_ID,
                    EMS_UPLOAD_FILE_PKG.GET_SUB_ID(col015,GET_STD_ID(col013,GET_MED_ID(col012, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS SUB_ID
                FROM QB, TABLE(
                        APEX_DATA_PARSER.parse(
                            p_content                     => QB.blob_content,
                            p_add_headers_row             => 'Y',
                            p_max_rows                    => 500,
                            p_file_name                   => QB.filename,
                            p_skip_rows                   => 1 ) 
                       )x 
                       --where x.col002 is not null or x.col003 is not null or x.col004 is not null or x.col005 is not null or x.col006 is not null 
                       order by line_number )
       loop
            APEX_COLLECTION.ADD_MEMBER(
                p_collection_name => 'STORE_QUESTION_BANK',
                p_c001            => i.col001,
                p_c002            => i.col002,
                p_c003            => i.col003,
                p_c004            => i.col004,
                p_c005            => i.col005,
                p_c006            => i.col006,
                p_c007            => i.col007,
                p_c008            => i.col008,
                p_c009            => i.col009,
                p_c010            => i.col010,
                p_c011            => i.col011,
                p_c012            => i.col012,
                p_c013            => i.col013,
                p_c014            => i.col014,
                p_c015            => i.col015,
                p_c016            => i.col016,
                p_c017            => i.col017,   
                p_c018            => i.col018,
                p_c019            => i.MED_ID,
                p_c020            => i.STD_ID,
                p_c021            => i.SEM_ID,
                p_c022            => i.SUB_ID
                );
    end loop;
    exception when others then logger.log_error('Error while parsing data to Collection : STORE_QUESTION_BANK');
        --apex_debug.error('Error inside Collection %s', sqlerrm);
END get_questionbank_to_collection;

-------------------------------------------UPLOAD SUBJECTS----------------------------------------------
procedure get_subjects_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER)
IS 
BEGIN
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(p_collection_name => 'STORE_SUBJECTS');

    for i in (with lst1 as (select * from apex_application_temp_files where name = P_FILE)
        SELECT line_number, col001, col002, col003, col004, col005, col006, col007,
            EMS_UPLOAD_FILE_PKG.GET_MED_ID(col001, p_inst_id, p_acyr_id) AS MED_ID,
            EMS_UPLOAD_FILE_PKG.GET_STD_ID(col002, EMS_UPLOAD_FILE_PKG.GET_MED_ID(col001, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS STD_ID,
            EMS_UPLOAD_FILE_PKG.GET_SEM_ID(col003, EMS_UPLOAD_FILE_PKG.GET_STD_ID(col002,EMS_UPLOAD_FILE_PKG.GET_MED_ID(col001, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS SEM_ID
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
            p_collection_name => 'STORE_SUBJECTS',
            p_c001            => i.col001,
            p_c002            => i.col002,
            p_c003            => i.col003,
            p_c004            => i.col004,
            p_c005            => i.col005,
            p_c006            => i.col006,
            p_c007            => i.col007,
            p_c008            => i.MED_ID,
            p_c009            => i.STD_ID,
            p_c010            => i.SEM_ID
        );
    end loop;

    exception when others then logger.log_error('Error while parsing data to Collection : STORE_SUBJECTS');
        --apex_debug.error('Error inside Collection %s', sqlerrm);
END get_subjects_to_collection;

--------------------------------------------------UPLOAD EMPLOYEE----------------------------------------------------------
procedure get_employee_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
AS
Begin
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(p_collection_name => 'STORE_EMPLOYEES' );

        for i in (with file1 as (select * from apex_application_temp_files where name = P_FILE)
            SELECT line_number, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013,
                    col014, col015, col016, col017, col018, col019, col020, col021, col022, col023, col024, col025, col026, col027, col028, col029, col030
                    --col031, col032, col033, col034, col035, col036, col037, col038, col039, col040
                    --col041, col042, col043, col044, col045, col046, col047, col048, col049, col050, 
                    /*EMS_UPLOAD_FILE_PKGGET_STATE_ID(col033,EMS_UPLOAD_FILE_PKGGET_COUNTRY_ID(col032)) AS STATE_ID,
                    EMS_UPLOAD_FILE_PKGGET_COUNTRY_ID(col032) AS COUNTRY_ID,
                    EMS_UPLOAD_FILE_PKGGET_STATE_ID(col038,EMS_UPLOAD_FILE_PKGGET_COUNTRY_ID(col037)) AS TEMP_STATE_ID,
                    EMS_UPLOAD_FILE_PKGGET_COUNTRY_ID(col037) AS TEMP_COUNTRY_ID*/
                FROM file1, TABLE(
                        APEX_DATA_PARSER.parse(
                            p_content                     => file1.blob_content,
                            p_add_headers_row             => 'Y',
                            p_max_rows                    => 500,
                            p_file_name                   => file1.filename,
                            p_skip_rows                   => 1 ) 
                       )x 
                       order by line_number )
       loop
                APEX_COLLECTION.ADD_MEMBER(
                p_collection_name => 'STORE_EMPLOYEES',
                p_c001            => i.col001,
                p_c002            => i.col002,
                p_c003            => i.col003,
                p_c004            => i.col004,
                p_c005            => i.col005,
                p_c006            => i.col006,--TO_DATE(i.col006,'YYYY/MM/DD'),
                p_c007            => i.col007,
                p_c008            => i.col008,
                p_c009            => i.col009,
                p_c010            => i.col010,
                p_c011            => i.col011,
                p_c012            => i.col012,
                p_c013            => i.col013,
                p_c014            => i.col014,
                p_c015            => i.col015,
                p_c016            => i.col016,
                p_c017            => i.col017,   
                p_c018            => i.col018,
                p_c019            => i.col019,
                p_c020            => i.col020,
                p_c021            => i.col021,
                p_c022            => i.col022,
                p_c023            => i.col023,
                p_c024            => i.col024,
                p_c025            => i.col025,
                p_c026            => i.col026,
                p_c027            => i.col027,   
                p_c028            => i.col028,
                p_c029            => i.col029
                /*p_c030            => i.col030,
                p_c031            => i.col031,
                p_c032            => i.col032,
                p_c033            => i.col033,
                p_c034            => i.col034,
                p_c035            => i.col035,
                p_c036            => i.col036,
                p_c037            => i.col037,   
                p_c038            => i.col038,
                p_c039            => i.col039,
                p_c040            => i.col040
                p_c041            => i.TEMP_COUNTRY_ID,
                p_c042            => i.STATE_ID,
                p_c043            => i.COUNTRY_ID,
                p_c044            => i.TEMP_STATE_ID*/
                );
    end loop;

    exception when others then logger.log_error('Error while parsing data to Collection : STORE_EMPLOYEES');
    --apex_debug.error('Error inside Collection %s', sqlerrm);
end ;

-------------------------------------------UPLOAD ASSIGN SUBJECTS----------------------------------------------
procedure get_ass_subjects_to_collection(P_FILE IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER)
IS 
BEGIN
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(p_collection_name => 'STORE_ASSIGN_SUBJECTS');

    for i in (with lst1 as (select * from apex_application_temp_files where name = P_FILE)
        SELECT line_number, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010,
            (SELECT EMPLOYEE_ID FROM EMPLOYEE_DET WHERE LOWER(FIRSTNAME) || ' ' || LOWER(MIDDLENAME) || ' ' || LOWER(LASTNAME) = LOWER(col001)) AS EMP_ID,
            EMS_UPLOAD_FILE_PKG.GET_MED_ID(col002, p_inst_id, p_acyr_id) AS MED_ID,
            EMS_UPLOAD_FILE_PKG.GET_STD_ID(col003,EMS_UPLOAD_FILE_PKG.GET_MED_ID(col002, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS STD_ID,
            EMS_UPLOAD_FILE_PKG.GET_SEM_ID(col004,GET_STD_ID(col003,GET_MED_ID(col002, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS SEM_ID,
            EMS_UPLOAD_FILE_PKG.GET_DIV_ID(col005,EMS_UPLOAD_FILE_PKG.GET_STD_ID(col003,GET_MED_ID(col002, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS DIV_ID,
            EMS_UPLOAD_FILE_PKG.GET_SUB_ID(col006,EMS_UPLOAD_FILE_PKG.GET_STD_ID(col003,GET_MED_ID(col002, p_inst_id, p_acyr_id), p_inst_id, p_acyr_id), p_inst_id, p_acyr_id) AS SUB_ID
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
            p_collection_name => 'STORE_ASSIGN_SUBJECTS',
            p_c001            => i.col001,
            p_c002            => i.col002,
            p_c003            => i.col003,
            p_c004            => i.col004,
            p_c005            => i.col005,
            p_c006            => i.col006,
            p_c007            => i.col007,
            p_c008            => i.EMP_ID,
            p_c009            => i.MED_ID,
            p_c010            => i.STD_ID,
            p_c011            => i.SEM_ID,
            p_c012            => i.DIV_ID,
            p_c013            => i.SUB_ID
        );
    end loop;

    exception when others then logger.log_error('Error while parsing data to Collection : STORE_ASSIGN_SUBJECTS');
        --apex_debug.error('Error inside Collection %s', sqlerrm);
END get_ass_subjects_to_collection;

---------------------------------STUDENT-------------------------------------
FUNCTION GET_STUD_ID(p_stud_f IN VARCHAR2,p_stud_m IN VARCHAR2,p_stud_l IN VARCHAR2,p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
RETURN NUMBER 
IS
    stud_id NUMBER;
    l_scope logger_logs.scope%type := 'EMS_UPLOAD_FILE_PKGGET_STUD_ID'; 
    l_params logger.tab_param;
BEGIN  
    SELECT STUDENT_ID into stud_id FROM STUDENTS_DET 
    WHERE UPPER(FIRSTNAME) = UPPER(p_stud_f)
        AND UPPER(MIDDLENAME) = UPPER(p_stud_m)
        AND UPPER(LASTNAME) = UPPER(p_stud_l)
        AND INSTITUTE_ID = p_inst_id
        AND AC_YEAR_ID = p_acyr_id;
    RETURN(stud_id);
END;

-----------------------------------MEDIUM--------------------------------------
FUNCTION GET_MED_ID(p_medium IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
RETURN NUMBER 
IS
    medium_id NUMBER;
    l_scope logger_logs.scope%type := 'EMS_UPLOAD_FILE_PKGGET_MED_ID'; 
    l_params logger.tab_param; 
BEGIN  
    --logger.log('START Function', l_scope, null, l_params);

    SELECT MED_ID into medium_id FROM MEDIUM_MST 
    WHERE LOWER(MEDIUM_NAME) = LOWER(p_medium) 
        AND INSTITUTE_ID = p_inst_id
        AND AC_YEAR_ID = p_acyr_id;
    RETURN(medium_id);
END;

----------------------------------STANDARD---------------------------------
FUNCTION GET_STD_ID(p_std IN VARCHAR2, p_med IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER)
RETURN NUMBER 
IS
    stand_id NUMBER;
    l_scope logger_logs.scope%type := 'EMS_UPLOAD_FILE_PKGGET_STD_ID'; 
    l_params logger.tab_param; 
BEGIN  
    SELECT STD_ID into stand_id FROM STANDARD_MST 
    WHERE LOWER(STD_NAME) = LOWER(p_std)
        AND MED_ID = p_med
        AND INSTITUTE_ID = p_inst_id
        AND AC_YEAR_ID = p_acyr_id;
    RETURN(stand_id);
END;

--------------------------------SEMESTER------------------------------------
FUNCTION GET_SEM_ID(p_sem IN VARCHAR2,p_std IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
RETURN NUMBER 
IS
    semt_id NUMBER;
    l_scope logger_logs.scope%type := 'EMS_UPLOAD_FILE_PKGGET_SEM_ID'; 
    l_params logger.tab_param; 
BEGIN  
    SELECT SEM_ID into semt_id FROM SEMESTER_MST 
    WHERE LOWER(SEM_NAME) = LOWER(p_sem) 
        AND STD_ID = p_std
        AND INSTITUTE_ID = p_inst_id
        AND AC_YEAR_ID = p_acyr_id;
    RETURN(semt_id);

END;

--------------------------------DIVISION------------------------------------
FUNCTION GET_DIV_ID(p_div IN VARCHAR2, p_std IN NUMBER, p_inst_id IN NUMBER, p_acyr_id IN NUMBER)  
RETURN NUMBER 
IS
    divi_id NUMBER;
    l_scope logger_logs.scope%type := 'EMS_UPLOAD_FILE_PKGGET_DIV_ID'; 
    l_params logger.tab_param; 
BEGIN  
    SELECT DIVISION_ID into divi_id FROM DIVISION_MST 
    WHERE LOWER(DIV_NAME) = LOWER(p_div) 
        AND STD_ID = p_std
        AND INSTITUTE_ID = p_inst_id
        AND AC_YEAR_ID = p_acyr_id;
    RETURN(divi_id);
END;

---------------------------------SUBJECT-----------------------------------
FUNCTION GET_SUB_ID(p_sub IN VARCHAR2, p_std IN NUMBER, p_inst_id IN NUMBER, p_acyr_id IN NUMBER)  
RETURN NUMBER 
IS
    subj_id NUMBER;
    l_scope logger_logs.scope%type := 'EMS_UPLOAD_FILE_PKGGET_SUB_ID'; 
    l_params logger.tab_param; 
BEGIN  
    SELECT SUB_ID into subj_id FROM SUBJECT_MST 
    WHERE LOWER(SUBJECT_NAME) = LOWER(p_sub) 
        AND STD_ID = p_std
        AND INSTITUTE_ID = p_inst_id
        AND AC_YEAR_ID = p_acyr_id;
    RETURN(subj_id);
END;

-----------------------------------TIME-------------------------------------
FUNCTION GET_TIME_ID(p_from IN VARCHAR2, p_to IN VARCHAR2, p_inst_id IN NUMBER, p_acyr_id IN NUMBER) 
RETURN NUMBER 
IS
    time_id NUMBER;
    l_scope logger_logs.scope%type := 'EMS_UPLOAD_FILE_PKGGET_TIME_ID'; 
    l_params logger.tab_param; 
BEGIN  
    SELECT TIME_ID into time_id FROM TIME_MST 
    WHERE FROM_TIME = p_from  
        AND TO_TIME = p_to
        AND INSTITUTE_ID = p_inst_id
        AND AC_YEAR_ID = p_acyr_id;
    RETURN(time_id);
END;

----------------------------------COUNTRY---------------------------------
FUNCTION GET_COUNTRY_ID(p_country IN VARCHAR2) 
RETURN NUMBER 
IS
    count_id NUMBER;
    l_scope logger_logs.scope%type := 'EMS_UPLOAD_FILE_PKGGET_COUNTRY_ID'; 
    l_params logger.tab_param; 
BEGIN  
    SELECT COUNTRY_ID into count_id FROM COUNTRIES_MST 
        WHERE LOWER(COUNTRY_NAME) = LOWER(p_country);
    RETURN(count_id);
END;

----------------------------------STATE---------------------------------
FUNCTION GET_STATE_ID(p_state IN VARCHAR2,p_count_id IN VARCHAR2) 
RETURN NUMBER 
IS
    st_id NUMBER;
    l_scope logger_logs.scope%type := 'EMS_UPLOAD_FILE_PKGGET_STATE_ID'; 
    l_params logger.tab_param; 
BEGIN  
    SELECT STATE_ID into st_id FROM STATE_MST 
    WHERE LOWER(STATE_NAME) = LOWER(p_state) 
        AND COUNTRIES_ID = p_count_id;
    RETURN(st_id);
END;

END EMS_UPLOAD_FILE_PKG;

/
