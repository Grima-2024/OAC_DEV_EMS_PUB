--------------------------------------------------------
--  DDL for Package Body EMS_PROMOTION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."EMS_PROMOTION" as

---------------------------------------------------------------------------------------------
------------------------------------Class Settings-------------------------------------------
---------------------------------------------------------------------------------------------

procedure class_settings(p_selected IN VARCHAR2, p_inst_id IN NUMBER, p_curr_acyr_id IN NUMBER, p_new_acyr_id IN NUMBER)
IS
    l_med_nm VARCHAR2(15);
    l_std_nm VARCHAR2(15);
    l_sem_nm VARCHAR2(15);
    l_have_sem VARCHAR2(3);
    l_scope logger_logs.scope%type := 'EMS_PROMOTION.class_settings'; 
    l_params logger.tab_param; 
BEGIN
    --------------------MEDIUM---------------------------

	--Get Medium from Division IDs..
    FOR M IN (SELECT * FROM MEDIUM_MST 
            WHERE MED_ID IN (SELECT MED_ID FROM DIVISION_MST 
                    WHERE DIVISION_ID IN (SELECT * FROM TABLE (apex_string.split_numbers(p_selected,':')))))
    LOOP
		--Insert Medium in new academic year and set status of new academic year to 'Active'
        INSERT INTO MEDIUM_MST (MEDIUM_NAME, MED_SHORT_NAME, INSTITUTE_ID, AC_YEAR_ID, STATUS)
        VALUES (M.MEDIUM_NAME, M.MED_SHORT_NAME, p_inst_id, p_new_acyr_id, 'Active');
        
		--Update status of old medium to 'Inactive'
        UPDATE MEDIUM_MST 
        SET STATUS = 'Inactive'
        WHERE AC_YEAR_ID = p_curr_acyr_id
            AND MED_ID = M.MED_ID 
            AND INSTITUTE_ID = p_inst_id;
    END LOOP;
    
    FOR I IN (SELECT * FROM TABLE (apex_string.split_numbers(p_selected,':')))
    LOOP
        FOR J IN (SELECT MED_ID, STD_ID, SEM_ID, DIVISION_ID FROM DIVISION_MST WHERE DIVISION_ID = I.COLUMN_VALUE)
        LOOP
            SELECT MEDIUM_NAME INTO l_med_nm FROM MEDIUM_MST WHERE MED_ID = J.MED_ID;
            SELECT STD_NAME, HAVE_SEMESTER INTO l_std_nm, l_have_sem FROM STANDARD_MST WHERE STD_ID = J.STD_ID; 
            
            --------------------STANDARD------------------
			--Insert Standard in new academic year and set status of new academic year to 'Active'
            INSERT INTO STANDARD_MST (
				STD_NAME,	
				STD_SHORT_NAME,	
				MED_ID, 
				INSTITUTE_ID, 
				AC_YEAR_ID, 
				HAVE_SEMESTER, 
				STATUS)
            VALUES(
                (SELECT STD_NAME FROM STANDARD_MST WHERE STD_ID = J.STD_ID),
                (SELECT STD_SHORT_NAME FROM STANDARD_MST WHERE STD_ID = J.STD_ID),
                (SELECT MED_ID FROM MEDIUM_MST WHERE UPPER(MEDIUM_NAME) = UPPER(l_med_nm) AND AC_YEAR_ID = p_new_acyr_id),
                p_inst_id,
                p_new_acyr_id,
                (SELECT HAVE_SEMESTER FROM STANDARD_MST WHERE STD_ID = J.STD_ID),
                'Active');
            
			--Update status of old standard to 'Inactive'
            UPDATE STANDARD_MST
            SET STATUS = 'Inactive'
            WHERE STD_ID = J.STD_ID
                AND AC_YEAR_ID = p_curr_acyr_id
                AND MED_ID = J.MED_ID 
                AND INSTITUTE_ID = p_inst_id;
            
            -----------------------SEMESTER---------------------
            --Insert Semester in new academic year and set status of new academic year to 'Active'
			IF(l_have_sem = 'Y') THEN
                SELECT SEM_NAME INTO l_sem_nm FROM SEMESTER_MST WHERE SEM_ID = J.SEM_ID;

                INSERT INTO SEMESTER_MST(SEM_ID,
                    SEM_NAME,	
                    SEM_CODE,
                    STD_ID,
                    INSTITUTE_ID,
                    AC_YEAR_ID,
                    STATUS)
                VALUES(SEMESTER_MST_SEQ.NEXTVAL,
                    l_sem_nm,
                    (SELECT SEM_CODE FROM SEMESTER_MST WHERE SEM_ID = J.SEM_ID),
                    (SELECT STD_ID FROM STANDARD_MST WHERE UPPER(STD_NAME) = UPPER(l_std_nm) AND AC_YEAR_ID = p_new_acyr_id),
                    p_inst_id,
                    p_new_acyr_id,
                    'Active');
            END IF;

			--Update status of old semester to 'Inactive'
            UPDATE SEMESTER_MST
            SET STATUS = 'Inactive'
            WHERE STD_ID = J.STD_ID
                AND SEM_ID = J.SEM_ID
                AND AC_YEAR_ID = p_curr_acyr_id
                AND INSTITUTE_ID = p_inst_id;
                
            ----------------------DIVISION-----------------------
			--Insert Division in new academic year and set status of new academic year to 'Active'
            INSERT INTO DIVISION_MST(DIVISION_ID,
                DIV_NAME,
                DIV_CODE,
                STD_ID,
                INSTITUTE_ID,
                AC_YEAR_ID,
                MED_ID,
                SEM_ID,
                STATUS)
            VALUES(DIVISION_MST_SEQ.NEXTVAL,
                (SELECT DIV_NAME FROM DIVISION_MST WHERE DIVISION_ID = J.DIVISION_ID),
                (SELECT DIV_CODE FROM DIVISION_MST WHERE DIVISION_ID = J.DIVISION_ID),
                (SELECT STD_ID FROM STANDARD_MST WHERE UPPER(STD_NAME) = UPPER(l_std_nm) AND AC_YEAR_ID = p_new_acyr_id),
                p_inst_id,
                p_new_acyr_id,
                (SELECT MED_ID FROM MEDIUM_MST WHERE UPPER(MEDIUM_NAME) = UPPER(l_med_nm) AND AC_YEAR_ID = p_new_acyr_id),
                (SELECT SEM_ID FROM SEMESTER_MST WHERE UPPER(SEM_NAME) = UPPER(l_sem_nm) AND AC_YEAR_ID = p_new_acyr_id),
                'Active'); 
            
			--Update status of old division to 'Inactive'
            UPDATE DIVISION_MST
            SET STATUS = 'Inactive'
            WHERE STD_ID = J.STD_ID
                AND DIVISION_ID = J.DIVISION_ID
                AND AC_YEAR_ID = p_curr_acyr_id
                AND INSTITUTE_ID = p_inst_id;
                
        END LOOP;
    END LOOP;

    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception', l_scope, null, l_params); 
END class_settings;

---------------------------------------------------------------------------------------------
----------------------------------Subject Settings-------------------------------------------
---------------------------------------------------------------------------------------------

procedure subject_settings(p_selected IN VARCHAR2, p_inst_id IN NUMBER, p_curr_acyr_id IN NUMBER, p_new_acyr_id IN NUMBER)
IS
    l_med_name VARCHAR2(15);
    l_std_name VARCHAR2(15);
    l_have_seme VARCHAR2(3);
    l_sem_id NUMBER;
    l_scope logger_logs.scope%type := 'EMS_PROMOTION.subject_settings'; 
    l_params logger.tab_param; 
BEGIN
	--Loop through Subject IDs
    FOR I IN (SELECT * FROM TABLE(APEX_STRING.SPLIT_NUMBERS(p_selected,':')))
    LOOP
		--Get IDs for med,std,sem,sub of old subject Id
        FOR J IN (SELECT SUB_ID, MED_ID, STD_ID, SEM_ID FROM SUBJECT_MST WHERE SUB_ID = I.COLUMN_VALUE)
        LOOP
        
            SELECT MEDIUM_NAME INTO l_med_name FROM MEDIUM_MST WHERE MED_ID = J.MED_ID;
            SELECT STD_NAME, HAVE_SEMESTER INTO l_std_name, l_have_seme FROM STANDARD_MST WHERE STD_ID = J.STD_ID; 
            
			--Check whether Std has Sem or not .... if exists then fetch id of sem
            IF (l_have_seme = 'Y')THEN
                SELECT SEM_ID INTO l_sem_id FROM SEMESTER_MST
                WHERE UPPER(SEM_NAME) = (SELECT UPPER(SEM_NAME) FROM SEMESTER_MST WHERE SEM_ID = J.SEM_ID) 
                    AND AC_YEAR_ID = p_new_acyr_id;
            END IF;

			--Insert Subjects in new academic year and set status of new subjects to 'Active'
            INSERT INTO SUBJECT_MST(
                SUB_ID,
                SUB_CODE,
                SUBJECT_NAME,	
                SUBJECT_TYPE,
                MED_ID,	
                SEM_ID,
                STD_ID,	
                AC_YEAR_ID,	
                STATUS,
                INSTITUTE_ID)
            VALUES(
                SUBJECT_MST_SEQ.NEXTVAL,
                (SELECT SUB_CODE FROM SUBJECT_MST WHERE SUB_ID = J.SUB_ID),
                (SELECT SUBJECT_NAME FROM SUBJECT_MST WHERE SUB_ID = J.SUB_ID),
                (SELECT SUBJECT_TYPE FROM SUBJECT_MST WHERE SUB_ID = J.SUB_ID),
                (SELECT MED_ID FROM MEDIUM_MST WHERE UPPER(MEDIUM_NAME) = UPPER(l_med_name) AND AC_YEAR_ID = p_new_acyr_id),
                l_sem_id,
                (SELECT STD_ID FROM STANDARD_MST WHERE UPPER(STD_NAME) = UPPER(l_std_name) AND AC_YEAR_ID = p_new_acyr_id),
                p_new_acyr_id,
                'Active',
                p_inst_id);
            
			--Update status of old subject to 'Inactive'
            UPDATE SUBJECT_MST
            SET STATUS = 'Inactive'
            WHERE STD_ID = J.STD_ID
                AND MED_ID = J.MED_ID
                AND AC_YEAR_ID = p_curr_acyr_id
                AND INSTITUTE_ID = p_inst_id;
                
        END LOOP;
    END LOOP;

    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception', l_scope, null, l_params); 
END;

---------------------------------------------------------------------------------------------
--------------------------------------Promote Student----------------------------------------
---------------------------------------------------------------------------------------------

procedure promote_students(
    p_stud_id IN NUMBER,
    p_old_med IN NUMBER,
    p_old_std IN NUMBER,
    p_new_std IN NUMBER,
    p_new_acyr_id IN NUMBER,
    p_inst_id IN NUMBER)
IS
    l_stud_photo BLOB;
    l_stud_id NUMBER;
    l_par_id NUMBER;
BEGIN
	--Loop through selected Student IDs
    FOR J IN (SELECT * FROM STUDENTS_DET WHERE STUDENT_ID = p_stud_id)
    LOOP
        SELECT STUD_PHOTO INTO l_stud_photo FROM STUDENTS_DET WHERE STUDENT_ID = p_stud_id;

		--Insert Students in new academic year and set status of academic to 'Active'
        INSERT INTO STUDENTS_DET(
            STUDENT_ID, ADM_APPL_CODE, ADMISSION_DT, ADMISSION_YEAR, ADM_MED, ADM_STD, ADM_SEM, INSTITUTE_ID,
            CUR_MED, CUR_STD, CUR_SEM, GR_NO, ROLL_NO, STUD_PHOTO, FIRSTNAME, MIDDLENAME, LASTNAME, DOB, AGE, GENDER,
            STUD_CONT_NO, STUD_MOBILE_NO, STUD_EMAIL, PERMNT_ADDR, PERMNT_CITY, PERMNT_STATE, PERMNT_COUNTRY, PERMNT_PINCODE,
            TEMP_ADDR, TEMP_CITY, TEMP_STATE, TEMP_COUNTRY, TEMP_PINCODE, FATHERNAME, FMIDDLENAME, FLASTNAME,
            FCONT_NO, FMOBILE_NO, FATHER_OCCUPATION, MOTHERNAME, MMIDDLENAME, MLASTNAME, MCONT_NO, MMOBILE_NO,
            MOTHER_OCCUPATION, STATUS, IS_GRADUATE, USER_ID, DIVISION_ID, ADM_APPL_ID, AC_YEAR_ID, ACADEMIC_STATUS)
            
        VALUES(
            STUDENTS_DET_SEQ.NEXTVAL, J.ADM_APPL_CODE, J.ADMISSION_DT, J.ADMISSION_YEAR, J.ADM_MED, J.ADM_STD, J.ADM_SEM, J.INSTITUTE_ID,
            J.CUR_MED, p_new_std , J.CUR_SEM, J.GR_NO, J.ROLL_NO, l_stud_photo, J.FIRSTNAME, J.MIDDLENAME, J.LASTNAME, J.DOB, J.AGE, J.GENDER,
            J.STUD_CONT_NO, J.STUD_MOBILE_NO, J.STUD_EMAIL, J.PERMNT_ADDR, J.PERMNT_CITY, J.PERMNT_STATE, J.PERMNT_COUNTRY, J.PERMNT_PINCODE,
            J.TEMP_ADDR, J.TEMP_CITY, J.TEMP_STATE, J.TEMP_COUNTRY, J.TEMP_PINCODE, J.FATHERNAME, J.FMIDDLENAME, J.FLASTNAME,
            J.FCONT_NO, J.FMOBILE_NO, J.FATHER_OCCUPATION, J.MOTHERNAME, J.MMIDDLENAME, J.MLASTNAME, J.MCONT_NO, J.MMOBILE_NO,
            J.MOTHER_OCCUPATION, J.STATUS, J.IS_GRADUATE, J.USER_ID, J.DIVISION_ID, J.ADM_APPL_ID, p_new_acyr_id , 'Active')
        RETURNING STUDENT_ID INTO l_stud_id;

		--Update academic status of old Student ID to 'Inactive'
        UPDATE STUDENTS_DET
        SET ACADEMIC_STATUS = 'Inactive'
        WHERE STUDENT_ID = p_stud_id
            AND CUR_MED = p_old_med
            AND CUR_STD = p_old_std;
    END LOOP;

    FOR P IN (SELECT PARENTS_ID_FK FROM STUD_PAR_MAP WHERE STUDENT_ID_FK = p_stud_id)
    LOOP
		--Get Parents ID of selected Students..
        FOR K IN (SELECT * FROM PARENTS_DET WHERE PARENTS_ID = P.PARENTS_ID_FK)
        LOOP
			--Insert Parents in new academic year
            INSERT INTO PARENTS_DET (PARENTS_ID, FIRSTNAME, MIDDLENAME, LASTNAME, ADDRESS, CITY, STATE, COUNTRY, PINCODE,
                MOBILENO, PHONENO, OCCUPATION, POSITION, OFFICE_ADDRESS, OFFICEPHONE, OFFICEMOBILE, EXTENSIONNO,
                INSTITUTE_ID, USER_ID, AC_YEAR_ID)
            VALUES (PARENTS_DET_SEQ.NEXTVAL, K.FIRSTNAME, K.MIDDLENAME, K.LASTNAME, K.ADDRESS, K.CITY, K.STATE, K.COUNTRY, K.PINCODE,
                K.MOBILENO, K.PHONENO, K.OCCUPATION, K.POSITION, K.OFFICE_ADDRESS, K.OFFICEPHONE, K.OFFICEMOBILE, K.EXTENSIONNO,
                K.INSTITUTE_ID, K.USER_ID, p_new_acyr_id)
            RETURNING PARENTS_ID INTO l_par_id;
                
            INSERT INTO STUD_PAR_MAP(MAP_ID_PK, STUDENT_ID_FK, PARENTS_ID_FK,INSTITUTE_ID)
            VALUES(STUD_PAR_MAP_SEQ.NEXTVAL, l_stud_id, l_par_id, p_inst_id);

			--Update academic status of old Parents ID to 'Inactive'
            UPDATE PARENTS_DET 
            SET ACADEMIC_STATUS = 'Inactive'
            WHERE PARENTS_ID = K.PARENTS_ID;
        END LOOP;
    END LOOP;
END promote_students;

END EMS_PROMOTION;

/
