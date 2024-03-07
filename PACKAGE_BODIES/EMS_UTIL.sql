--------------------------------------------------------
--  DDL for Package Body EMS_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."EMS_UTIL" IS

function dynamic_nav_menu(p_app_user IN VARCHAR2, p_app_id IN NUMBER)
RETURN VARCHAR2
IS
	l_user_type VARCHAR2(10);
	l_query varchar2(4000);
	l_inst_id NUMBER;
BEGIN
	SELECT UT.USER_TYPE_CODE, UM.INSTUTUTE_ID INTO l_user_type, l_inst_id
	FROM USERS_TYPE_MST UT, USERS_MST UM
	WHERE UT.USER_TYPE_ID = UM.USER_TYPE_ID
		AND LOWER(UM.USERNAME) = LOWER(p_app_user);

	IF(l_user_type = 'SADM') THEN
		l_query := 
			'SELECT DISTINCT
				CASE WHEN PARENT_ENTRY_TEXT IS NULL THEN ''1''
				ELSE ''2''
				END AS list_level,
				ENTRY_TEXT label, 
				ENTRY_TARGET target,
				v(''APP_PAGE_ID'') AS is_current,
				ENTRY_IMAGE image,
				DISPLAY_SEQUENCE as seq_order
			FROM APEX_APPLICATION_LIST_ENTRIES
			WHERE APPLICATION_ID = '||p_app_id||'
				AND LIST_NAME = ''Desktop Navigation Menu'' 
				AND CONDITION_TYPE IS NULL
				AND (AUTHORIZATION_SCHEME = ''SUPERADMIN_RIGHTS''
					OR AUTHORIZATION_SCHEME = ''SUPADMIN_ADMIN_RIGHTS''
					OR AUTHORIZATION_SCHEME = ''SADMIN_ADMIN_EMP_RIGHTS''
					OR AUTHORIZATION_SCHEME = ''SADMIN_ADMIN_PAR_RIGHTS''
					OR AUTHORIZATION_SCHEME IS NULL)
			ORDER BY SEQ_ORDER';
		RETURN l_query;
	ELSIF(l_user_type = 'ADM') THEN
		l_query := 
			'SELECT DISTINCT
				MODULE_LEVEL list_level,
				MODULE_NM label, 
				MODULE_PG target,
				v(''APP_PAGE_ID'') AS is_current,
				MODULE_ICON image,
				SEQ_ORDER
			FROM EMS_MODULE_MST EMM, EMS_MODULE_MAPPING MM
			WHERE EMM.MODULE_ID = MM.MODULE_ID
				AND MM.INSTITUTE_ID = '||l_inst_id||'
				AND MM.STATUS = ''Active''
				AND MM.USER_TYPE_ID = EMS_UTIL.get_usertypeid(''ADM'', '||l_inst_id||')
				AND (EMM.AUTH_SCHEME = ''SADMIN_ADMIN_EMP_RIGHTS''
					OR EMM.AUTH_SCHEME = ''SADMIN_ADMIN_PAR_RIGHTS''
					OR EMM.AUTH_SCHEME = ''SUPADMIN_ADMIN_RIGHTS''
					OR EMM.AUTH_SCHEME = ''SUPERADMIN_RIGHTS''
					OR EMM.AUTH_SCHEME = ''ADMIN_RIGHTS''
					OR EMM.AUTH_SCHEME IS NULL)
			START WITH PARENT_ENTRY IS NULL
			CONNECT BY PRIOR MODULE_NM = PARENT_ENTRY 
			ORDER BY SEQ_ORDER';
		RETURN l_query;
	ELSIF(l_user_type = 'EMP') THEN
		l_query := 
			'SELECT DISTINCT
				MODULE_LEVEL list_level,
				MODULE_NM label, 
				MODULE_PG target,
				v(''APP_PAGE_ID'') AS is_current,
				MODULE_ICON image,
				SEQ_ORDER
			FROM EMS_MODULE_MST EMM, EMS_MODULE_MAPPING MM
			WHERE EMM.MODULE_ID = MM.MODULE_ID
				AND MM.INSTITUTE_ID = '||l_inst_id||'
				AND MM.STATUS = ''Active''
				AND MM.USER_TYPE_ID = EMS_UTIL.get_usertypeid(''EMP'', '||l_inst_id||')
				AND (EMM.AUTH_SCHEME = ''EMPLOYEE_RIGHTS''
					OR EMM.AUTH_SCHEME = ''SADMIN_ADMIN_EMP_RIGHTS''
					OR EMM.AUTH_SCHEME IS NULL)
			START WITH PARENT_ENTRY IS NULL
			CONNECT BY PRIOR MODULE_NM = PARENT_ENTRY 
			ORDER BY SEQ_ORDER';
		RETURN l_query;
	ELSIF(l_user_type = 'PAR') THEN
		l_query := 
			'SELECT DISTINCT
				MODULE_LEVEL list_level,
				MODULE_NM label, 
				MODULE_PG target,
				v(''APP_PAGE_ID'') AS is_current,
				MODULE_ICON image,
				SEQ_ORDER
			FROM EMS_MODULE_MST EMM, EMS_MODULE_MAPPING MM
			WHERE EMM.MODULE_ID = MM.MODULE_ID
				AND MM.INSTITUTE_ID = '||l_inst_id||'
				AND MM.STATUS = ''Active''
				AND MM.USER_TYPE_ID = EMS_UTIL.get_usertypeid(''ADM'', '||l_inst_id||')
				AND (EMM.AUTH_SCHEME = ''PARENTS_RIGHTS''
					OR EMM.AUTH_SCHEME = ''PAR_STUD_RIGHTS''
					OR EMM.AUTH_SCHEME = ''SADMIN_ADMIN_PAR_RIGHTS''
					OR EMM.AUTH_SCHEME IS NULL)
			START WITH PARENT_ENTRY IS NULL
			CONNECT BY PRIOR MODULE_NM = PARENT_ENTRY 
			ORDER BY SEQ_ORDER';
		RETURN l_query;
	ELSIF(l_user_type = 'STUD') THEN
		l_query := 
			'SELECT DISTINCT
				MODULE_LEVEL list_level,
				MODULE_NM label, 
				MODULE_PG target,
				v(''APP_PAGE_ID'') AS is_current,
				MODULE_ICON image,
				SEQ_ORDER
			FROM EMS_MODULE_MST EMM, EMS_MODULE_MAPPING MM
			WHERE EMM.MODULE_ID = MM.MODULE_ID
				AND MM.INSTITUTE_ID = '||l_inst_id||'
				AND MM.STATUS = ''Active''
				AND MM.USER_TYPE_ID = EMS_UTIL.get_usertypeid(''ADM'', '||l_inst_id||')
				AND (EMM.AUTH_SCHEME = ''STUDENT_RIGHTS''
					OR EMM.AUTH_SCHEME = ''PAR_STUD_RIGHTS''
					OR EMM.AUTH_SCHEME IS NULL)
			START WITH PARENT_ENTRY IS NULL
			CONNECT BY PRIOR MODULE_NM = PARENT_ENTRY 
			ORDER BY SEQ_ORDER';
		RETURN l_query;
	END IF;
END;

-------------------------------------Get User Type ID------------------------------------
function get_usertypeid(p_usertypecode IN VARCHAR, p_inst_id IN NUMBER) RETURN NUMBER
IS
	l_utype_id NUMBER;
BEGIN
	SELECT USER_TYPE_ID INTO l_utype_id
	FROM USERS_TYPE_MST
	WHERE USER_TYPE_CODE = p_usertypecode
		AND INSTITUTE_ID = p_inst_id;
	
	RETURN l_utype_id;
END;

-------------------------------------Delete Institute------------------------------------
procedure delete_institute(p_inst_id IN NUMBER)
IS
BEGIN
    -------------Library-----------------
    DELETE FROM LIBFINEDET WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM BOOKSISSUEDET WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM BOOKISSUE_QUOTA_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM BOOKSLISTDET WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM BOOKSCATEGORYDET WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM LIBRARY_MST WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Hostel-----------------
    DELETE FROM HOSTEL_FEES_CHILD WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM HOSTEL_FEES_DET WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM HOSTEL_FEES_STRUCTURE WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM HOSTEL_ROOM_ASSIGN_DET WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM HOSTEL_ROOM_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM HOSTEL_MST WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Transportation-----------------
    DELETE FROM VEHICAL_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM ROUTE_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM POINTS_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM TRANSPORT_DET WHERE STUDENT_ID IN (SELECT STUDENT_ID FROM STUDENTS_DET WHERE INSTITUTE_ID = p_inst_id);
    
    -------------Time Table-----------------
    DELETE FROM SCHEDULE_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM AUTO_SCHEDULER WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM TIME_MST WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Attendance-----------------
    DELETE FROM STUDENT_LEAVE_DETAILS WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM AT_STUD_ATTENDANCE WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Test-----------------
    DELETE FROM TMS.EMS_TEST_RESULT WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM TMS.EMS_TEST_TRACK WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM TMS.EMS_TEST_INFO WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM TMS.EMS_TEST_QUES WHERE TEST_FK IN (SELECT TEST_PK FROM TMS.EMS_TEST WHERE INSTITUTE_ID = p_inst_id);
    DELETE FROM TMS.EMS_TEST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM TMS.EMS_QUESTION_OPTION WHERE QID_FK IN (SELECT QID_PK FROM TMS.EMS_QUESTION_BANK WHERE INSTITUTE_ID = p_inst_id);
    DELETE FROM TMS.EMS_QUESTION_BANK WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Event-----------------
    DELETE FROM EVENT_TYPE_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM INSTITUTE_CALENDAR WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Message-----------------
    DELETE FROM TMS.EMS_MEMO WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Mail-----------------
    DELETE FROM TMS.EMS_EMAIL WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Employee-----------------
    DELETE FROM EMP_PAYROLL_DET WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM EMP_DOCUMENTS_DET WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE_DET WHERE INSTITUTE_ID = p_inst_id);
    DELETE FROM EMP_EDUCATION_DET WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE_DET WHERE INSTITUTE_ID = p_inst_id);
    DELETE FROM ASSIGN_SUB_DET WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM EMPLOYEE_DET WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Student Fees-----------------
    DELETE FROM STUDENT_FEES_DET WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM FEES_STRUCTURE_YEARLY WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM FEES_SUB_TYPE WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM FEES_TYPE_MST WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Students, Parents and Admission-----------------
    DELETE FROM GUARDIAN_DET WHERE STUDENT_ID IN (SELECT STUDENT_ID FROM STUDENTS_DET WHERE INSTITUTE_ID = p_inst_id);
    DELETE FROM HEALTH_REPORT WHERE STUDENT_ID IN (SELECT STUDENT_ID FROM STUDENTS_DET WHERE INSTITUTE_ID = p_inst_id);
    DELETE FROM STUD_DOC_DET WHERE INSTITUTE_ID = p_inst_id;
 
    DELETE FROM STUD_PAR_MAP WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM PARENTS_DET WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM STUDENTS_DET WHERE INSTITUTE_ID = p_inst_id;
 
    DELETE FROM SAMPLE_ADMISSION_APPLICATION WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM ADMISSION_APPLICATION WHERE INSTITUTE_ID = p_inst_id;
    
    -------------Settings-----------------
    DELETE FROM DEPARTMENT_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM EMPLOYEE_TYPE_MST WHERE INSTITUTE_ID = p_inst_id;
 
    DELETE FROM SUBJECT_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM DIVISION_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM SEMESTER_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM STANDARD_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM MEDIUM_MST WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Institute and Academic Year-----------------
    DELETE FROM ACADEMIC_YEAR_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM INSTITUTE_MST WHERE INSTITUTE_ID = p_inst_id;
 
    -------------Users-----------------
    DELETE FROM USERS_TYPE_MST WHERE INSTITUTE_ID = p_inst_id;
    DELETE FROM USERS_MST WHERE USERNAME != 'superadmin' AND INSTUTUTE_ID = p_inst_id;
 
END delete_institute;
 
-------------------------------------Delete Parents------------------------------------
procedure delete_parents(p_parent_id IN NUMBER)
IS
    l_uid NUMBER;
BEGIN
    SELECT USER_ID INTO l_uid FROM PARENTS_DET WHERE PARENTS_ID = p_parent_id;
 
    DELETE FROM STUD_PAR_MAP WHERE PARENTS_ID_FK = p_parent_id;
 
    DELETE FROM PARENTS_DET WHERE PARENTS_ID = p_parent_id;
 
    DELETE FROM USERS_MST WHERE USER_ID = l_uid;
    
    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception', 'EMS_UTIL.delete_parents');
END delete_parents;
 
-------------------------------------Delete Student------------------------------------
procedure delete_students(p_stud_id IN NUMBER)
IS
    l_uid NUMBER;
    l_par_id NUMBER;
    l_puid NUMBER;
BEGIN
    SELECT USER_ID INTO l_uid 
    FROM STUDENTS_DET 
    WHERE STUDENT_ID = p_stud_id;
 
    SELECT PD.PARENTS_ID, PD.USER_ID INTO l_par_id, l_puid
    FROM STUDENTS_DET SD,PARENTS_DET PD,STUD_PAR_MAP SM
    WHERE SM.STUDENT_ID_FK = SD.STUDENT_ID  
        AND SM.PARENTS_ID_FK = PD.PARENTS_ID  
        AND SD.AC_YEAR_ID = PD.AC_YEAR_ID
        AND SD.STUDENT_ID = p_stud_id;
    
    DELETE FROM LIBFINEDET WHERE STUDENTID = p_stud_id;
    DELETE FROM BOOKSISSUEDET WHERE STUDENT_ID = p_stud_id;
 
    DELETE FROM HOSTEL_FEES_CHILD WHERE STUDENT_ID = p_stud_id;
    DELETE FROM HOSTEL_FEES_DET WHERE STUDENT_ID = p_stud_id;
    DELETE FROM HOSTEL_ROOM_ASSIGN_DET WHERE STUDENT_ID = p_stud_id;
 
    DELETE FROM TRANSPORT_DET WHERE STUDENT_ID = p_stud_id;
 
    DELETE FROM STUDENT_LEAVE_DETAILS WHERE STUDENT_ID = p_stud_id;
    DELETE FROM AT_STUD_ATTENDANCE WHERE STUDENT_ID = p_stud_id;
 
    DELETE FROM TMS.EMS_TEST_RESULT WHERE STUDENT_ID = p_stud_id;
    DELETE FROM TMS.EMS_TEST_TRACK WHERE STUDENT_ID = p_stud_id;
    DELETE FROM TMS.EMS_TEST_INFO WHERE STUDENT_ID = p_stud_id;
 
    DELETE FROM STUDENT_FEES_DET WHERE STUDENT_ID = p_stud_id;
 
    DELETE FROM GUARDIAN_DET WHERE STUDENT_ID = p_stud_id;
    DELETE FROM HEALTH_REPORT WHERE STUDENT_ID = p_stud_id;
    DELETE FROM STUD_DOC_DET WHERE STUDENT_ID = p_stud_id;
    DELETE FROM STUD_PAR_MAP WHERE STUDENT_ID_FK = p_stud_id;
    DELETE FROM PARENTS_DET WHERE PARENTS_ID = l_par_id;
    DELETE FROM STUDENTS_DET WHERE STUDENT_ID = p_stud_id;
 
    DELETE FROM USERS_MST WHERE USER_ID = l_uid;
    DELETE FROM USERS_MST WHERE USER_ID = l_puid;
 
    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception', 'EMS_UTIL.delete_students');
END delete_students;
 
-------------------------------------Delete Employee------------------------------------
procedure delete_employee(p_emp_id IN NUMBER)
IS
    l_emp_uid NUMBER;
BEGIN
    SELECT USER_ID INTO l_emp_uid FROM EMPLOYEE_DET WHERE EMPLOYEE_ID = p_emp_id;
 
    DELETE FROM LIBFINEDET WHERE EMPLOYEE_ID = p_emp_id;
    DELETE FROM BOOKSISSUEDET WHERE EMPLOYEE_ID = p_emp_id;
 
    DELETE FROM EMP_PAYROLL_DET WHERE EMPLOYEE_ID = p_emp_id;
    DELETE FROM EMP_DOCUMENTS_DET WHERE EMPLOYEE_ID = p_emp_id;
    DELETE FROM EMP_EDUCATION_DET WHERE EMPLOYEE_ID = p_emp_id;
    DELETE FROM ASSIGN_SUB_DET WHERE EMPLOYEE_ID = p_emp_id;
    DELETE FROM EMPLOYEE_DET WHERE EMPLOYEE_ID = p_emp_id;
 
    DELETE FROM USERS_MST WHERE USER_ID = l_emp_uid;
 
    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception', 'EMS_UTIL.delete_employee');
END delete_employee;
 
-------------------------------------Issue Book------------------------------------
procedure issue_book(
    p_emp_id IN NUMBER, 
    p_stud_id IN NUMBER, 
    p_lib_id IN NUMBER, 
    p_issue_date IN DATE, 
    p_return_date IN DATE, 
    p_inst_id IN NUMBER, 
    p_acyear_id IN NUMBER)
IS
    l_nocp NUMBER;
    l_allocated NUMBER;
    l_avail NUMBER;
BEGIN
    FOR I IN (SELECT SEQ_ID, C001, C002, C003, C004, C005, C006, C007, C008, C009, C010 FROM APEX_COLLECTIONS
        WHERE COLLECTION_NAME = 'SELECTED_BOOKS')
    LOOP
        SELECT NOOFCOPY INTO l_nocp 
        FROM BOOKSLISTDET 
        WHERE BOOKCAT_ID = I.C002 
            AND BOOKID = I.C001
            AND INSTITUTE_ID = p_inst_id;
 
        SELECT NVL(SUM(NOOFBOOK),0) INTO l_allocated
        FROM BOOKSISSUEDET 
        WHERE BOOKCAT_ID = I.C002 
            AND BOOKID = I.C001
            AND INSTITUTE_ID = p_inst_id;
 
        l_avail := l_nocp - l_allocated;
 
        IF(l_avail = 1) THEN
            APEX_ERROR.ADD_ERROR (
                p_message  => 'Book is out of Stock',
                p_display_location => apex_error.c_inline_in_notification);
        ELSE
            IF(l_allocated <= l_nocp) THEN
                IF(I.C010 <= (l_avail - 1)) THEN
 
                    INSERT INTO BOOKSISSUEDET(BOOKISSUEID, BOOKID, BOOKCAT_ID, EMPLOYEE_ID, STUDENT_ID, 
                        INSTITUTE_ID, LIB_ID, ISSUEDATE, RETURNDATE, NOOFBOOK, ISREWNEW, AC_YEARID, STATUS)
                    VALUES(BOOKSISSUEDET_SEQ.NEXTVAL, I.C001, I.C002, p_emp_id, p_stud_id,
                        p_inst_id, p_lib_id, p_issue_date, p_return_date, I.C010, 'No', p_acyear_id, 'Issued');
 
                    UPDATE BOOKSLISTDET
                    SET AVAIL_BOOKS = AVAIL_BOOKS - 1
                    WHERE BOOKCAT_ID = I.C002
                        AND BOOKID = I.C001
                        AND INSTITUTE_ID = p_inst_id;
                ELSE
                    APEX_ERROR.ADD_ERROR (
                    p_message  => 'No of copies entered is more than Availability',
                    p_display_location => apex_error.c_inline_in_notification);
                    
                END IF;
            ELSE
                APEX_ERROR.ADD_ERROR (
                    p_message  => 'Book is out of Stock',
                    p_display_location => apex_error.c_inline_in_notification);
            END IF;
        END IF;
    END LOOP;
END issue_book;
 
-------------------------------------Return Book------------------------------------
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
)
IS
    l_bkissue_id NUMBER(7);
BEGIN 
    IF(p_selected_user = 'stud') THEN
 
        SELECT BOOKISSUEID INTO l_bkissue_id
        FROM BOOKSISSUEDET 
        WHERE STUDENT_ID = p_stud_id
            AND LIB_ID = p_lib_id
            AND INSTITUTE_ID = p_inst_id
            AND AC_YEARID = p_acyr_id;
        
        INSERT INTO LIBFINEDET(
                LIBFINID, FINDATE, STUDENTID, INSTITUTE_ID, BOOKID, BOOKISSUEID, 
                CHARGE, AC_YEARID, LIB_ID, DESCR, STATUS
            )
        VALUES(
                LIBFINEDET_SEQ.NEXTVAL, p_findate, p_stud_id, p_inst_id, p_book_id, l_bkissue_id,
                p_charge, p_acyr_id, p_lib_id, p_desc, p_status
            );
 
        UPDATE BOOKSLISTDET 
        SET AVAIL_BOOKS = AVAIL_BOOKS + 1 
        WHERE BOOKID = p_book_id;
 
        UPDATE BOOKSISSUEDET
        SET STATUS = 'Returned'
        WHERE BOOKID = p_book_id
            AND LIB_ID = p_lib_id
            AND STUDENT_ID = p_stud_id
            AND INSTITUTE_ID = p_inst_id
            AND AC_YEARID = p_acyr_id;
    ELSE
        SELECT BOOKISSUEID INTO l_bkissue_id
        FROM BOOKSISSUEDET 
        WHERE EMPLOYEE_ID = p_emp_id
            AND LIB_ID = p_lib_id
            AND INSTITUTE_ID = p_inst_id
            AND AC_YEARID = p_acyr_id;
    
        INSERT INTO LIBFINEDET(
                LIBFINID, FINDATE, EMPLOYEE_ID, INSTITUTE_ID, BOOKID, BOOKISSUEID, 
                CHARGE, AC_YEARID, LIB_ID, DESCR, STATUS
            )
        VALUES(
                LIBFINEDET_SEQ.NEXTVAL, p_findate, p_emp_id, p_inst_id, p_empbook_id, l_bkissue_id,
                '0', p_acyr_id, p_lib_id, p_desc, p_status
            );
 
        UPDATE BOOKSLISTDET 
        SET AVAIL_BOOKS = AVAIL_BOOKS + 1 
        WHERE BOOKID = p_empbook_id;
 
        UPDATE BOOKSISSUEDET
        SET STATUS = 'Returned'
        WHERE BOOKID = p_empbook_id
            AND LIB_ID = p_lib_id
            AND EMPLOYEE_ID = p_emp_id
            AND INSTITUTE_ID = p_inst_id
            AND AC_YEARID = p_acyr_id;
    END IF;
END return_book;
 
-------------------------------------Renew Book------------------------------------
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
)
IS
BEGIN
    IF(p_selected_user = 'stud') THEN
        UPDATE BOOKSISSUEDET
        SET ISSUEDATE = p_issue_date,
            RETURNDATE = p_return_date,
            ISREWNEW = 'Yes',
            STATUS = 'Renewed'
        WHERE LIB_ID = p_lib_id
            AND INSTITUTE_ID = p_inst_id
            AND BOOKID = p_book_id
            AND STUDENT_ID = p_stud_id;
    ELSE
        UPDATE BOOKSISSUEDET
        SET ISSUEDATE = p_issue_date,
            RETURNDATE = p_return_date,
            ISREWNEW = 'Yes',
            STATUS = 'Renewed'
        WHERE LIB_ID = p_lib_id
            AND INSTITUTE_ID = p_inst_id
            AND BOOKID = p_empbook_id
            AND EMPLOYEE_ID = p_emp_id;
    END IF;
END renew_book;
 
-----------------------------Attendance : Upload Collection data to Table(final step)---------------------------
procedure upload_attendance_to_db(
    p_inst_id IN NUMBER,
    p_acyear_id IN NUMBER,
    p_app_user IN VARCHAR2
)
IS 
    l_emp_id NUMBER;
    l_count NUMBER;
    l_sch_id NUMBER;
BEGIN
    SELECT EMPLOYEE_ID INTO l_emp_id
    FROM EMPLOYEE_DET
    WHERE USER_ID = APP_UTIL.get_userid_fromname(p_app_user)
        AND INSTITUTE_ID = p_inst_id;
 
    FOR I IN (SELECT SEQ_ID,C004,C005,C006,C014,C015,C016,C017,C018,C019,C020
                FROM APEX_COLLECTIONS
                WHERE COLLECTION_NAME = 'STORE_FILE'
                ORDER BY 1)
    LOOP
        IF(I.C005 IS NULL) THEN
            APEX_ERROR.ADD_ERROR (
                p_message  => 'Fill the Attendance Status',
                p_display_location => apex_error.c_inline_in_notification);
        ELSE
            SELECT count(SCHEDULE_ID_FK) INTO l_count
            FROM AT_STUD_ATTENDANCE 
            WHERE TO_DATE(ATTEND_DT,'MM/DD/YYYY') = TO_DATE(I.C004,'MM/DD/YYYY') --TO_CHAR(I.C004,'MM/DD/YYYY') --TO_DATE(I.C004,'YYYY-DD-MM')
                AND SUBJECT = I.C019
                AND STUDENT_ID = I.C014;
     
            SELECT SCHEDULE_ID 
            INTO l_sch_id
            FROM SCHEDULE_MST 
            WHERE MED_ID = I.C015
                AND STD_ID = I.C016
                AND DIV_ID = I.C018 
                AND TO_DATE(S_DATE,'MM/DD/YYYY') = TO_DATE(I.C004,'MM/DD/YYYY')
               -- AND TIME_ID_FK = I.C020
                AND SUB_ID = I.C019;
     
            IF l_count > 0 THEN
                APEX_ERROR.ADD_ERROR (
                p_message  => 'Attendance Already Filled!',
                p_display_location => apex_error.c_inline_in_notification );
            ELSE
                INSERT INTO AT_STUD_ATTENDANCE(ATTEND_ID, EMPLOYEE_ID, ATTEND_DT, ATTEND_STATUS, REMARKS,
                     STD_ID, SEM_ID, DIV_ID, AC_YEAR_ID, STUDENT_ID, SUBJECT, SCHEDULE_ID_FK, INSTITUTE_ID, MED_ID)
                VALUES(AT_STUD_ATTEND_SEQ.nextval, l_emp_id, TO_DATE(I.C004,'MM/DD/YYYY'), I.C005, I.C006,
                    I.C016, I.C017, I.C018, p_acyear_id, I.C014, I.C019, l_sch_id, p_inst_id, I.C015);
            END IF;
        END IF;
    END LOOP;
       
    apex_collection.truncate_collection(p_collection_name=>'STORE_FILE');
 
END upload_attendance_to_db;
 
-----------------------------Subjects : Upload Collection data to Table(final step)---------------------------
 
procedure upload_subjects_to_db(p_aca_yr IN NUMBER, p_inst_id IN NUMBER)
IS
BEGIN
    FOR I IN (SELECT SEQ_ID,C001,C002,C003,C004,C005,C006,C007,C008,C009,C010
        FROM APEX_COLLECTIONS
        WHERE COLLECTION_NAME = 'STORE_SUBJECTS')
    LOOP
        INSERT INTO SUBJECT_MST (SUB_ID, SUBJECT_TYPE, SUB_CODE, SUBJECT_NAME, SUB_CREDIT, MED_ID, STD_ID, SEM_ID, STATUS, AC_YEAR_ID, INSTITUTE_ID)
        VALUES(SUBJECT_MST_SEQ.NEXTVAL, I.C004, I.C005, I.C006, I.C007, I.C008, I.C009, I.C010, 'Active', p_aca_yr, p_inst_id);
    END LOOP;
 
    APEX_COLLECTION.TRUNCATE_COLLECTION (p_collection_name => 'STORE_SUBJECTS');
 
    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception', 'EMS_UTIL.upload_subjects_to_db');
END upload_subjects_to_db;
 
-----------------------------Admission : Upload Collection data to Table(final step)---------------------------
procedure upload_admission_to_db(p_aca_yr IN NUMBER, p_inst_id IN NUMBER)
IS
    l_appl_code VARCHAR2(10);
    l_stud_email VARCHAR2(70);
    l_par_email VARCHAR2(70);
    l_get_appl_id VARCHAR2(10);
    l_temp_uid NUMBER(10);
    l_temp_puid NUMBER(10);
    l_stud_cnt NUMBER;
    l_par_cnt NUMBER;
    l_par_id_found NUMBER;
    l_rno NUMBER;
    l_par_utype NUMBER;
    l_stud_utype NUMBER;
    l_stud_id NUMBER;
    l_par_id NUMBER;
BEGIN
    
    FOR I IN (SELECT SEQ_ID,C001,C002,C003,C004,C005,C006,C007,C008,C009,C010,C011,C012,C013,C014,C015,C016,C017,C018,C019,C020,
        C021,C022,C023,C024,C025,C026,C027,C028,C029,C030,C031,C032,C033,C034,C035,C036,C037,C038,C039,C040,
        C041,C042,C043,C044,C045,C046,C047,C048,C049,C050,N001,N002,N003,N004,N005
        FROM APEX_COLLECTIONS
        WHERE COLLECTION_NAME = 'STORE_ADMISSION')
    LOOP    
        SELECT 'A' || TO_CHAR(ADMISSION_APP_CODE.NEXTVAL, 'FM0000000') INTO l_appl_code FROM DUAL;
 
        l_get_appl_id := ADM_APPL_MST_SEQ.NEXTVAL;
        l_temp_puid := USERS_MST_SEQ.NEXTVAL;
        l_temp_uid := USERS_MST_SEQ.NEXTVAL;
 
        INSERT INTO ADMISSION_APPLICATION(
            ADM_APPL_ID, ADM_APPL_CODE, FIRSTNAME, MIDDLENAME, LASTNAME, DATE_OF_BIRTH, AGE, GENDER, CATEGORY, MOTHER_TONGUE,
            NATIONALITY, RELIGION, FATHERNAME, HOME_ADDRESS, PINCODE, CITY, STATE_ID, COUNTRY_ID, TEL_NO, MOBILE_NO,
            OFFICE_ADDRESS, OFFICE_PHONE, EXTENSION_NO, OFFICE_MOBILE, OCCUPATION, POSITION, MED_ID, STD_ID, INSTITUTE_ID,
            ADMISSION_STATUS, STUDENT_ADMISSION_DT, ADMISSION_YEAR, STUD_CONT_NO, STUD_EMAIL, TEMP_ADDRESS, TEMP_CITY, TEMP_STATE,
            TEMP_COUNTRY, TEMP_PINCODE, FMIDDLENAME, FLASTNAME, MOTHERNAME,	MMIDDLENAME, MLASTNAME,	MMOBILE_NO,	MOTHER_OCCUPATION,AC_YEAR_ID)
        VALUES(
            l_get_appl_id, l_appl_code, I.C002, I.C003, I.C004, TO_CHAR(TO_DATE(I.C006,'YYYY-MM-DD'),'MM/DD/YYYY'), I.C007, I.C008, I.C009, I.C010,
            I.C011, I.C012, I.C013, I.C031, I.C035, I.C034, I.N003, I.N004, I.C019, I.C020,
            I.C021, I.C022, I.C023, I.C024, I.C017, I.C018, I.N001, I.N002, p_inst_id,
            'Pending', TO_CHAR(TO_DATE(I.C045,'YYYY-MM-DD'),'MM/DD/YYYY'), (SELECT EXTRACT(YEAR FROM TO_DATE(I.C045,'YYYY-MM-DD')) FROM DUAL), I.C005, 'ABC@GMAIL.COM',I.C036, I.C039, I.N005,
            I.C048, I.C040, I.C014, I.C015, I.C025, I.C026, I.C027, I.C028, I.C029, p_aca_yr
        )
        RETURNING ADM_APPL_ID INTO l_get_appl_id;
 
        SELECT LOWER(I.C002) || ADM_APPL_CODE ||'@'|| (SELECT LOWER(replace(INSTITUTE_NAME,chr(32),'')) FROM INSTITUTE_MST WHERE INSTITUTE_ID = AD.INSTITUTE_ID)  || '.com' 
        INTO l_stud_email 
        FROM ADMISSION_APPLICATION AD  
        WHERE ADM_APPL_ID = l_get_appl_id
            AND INSTITUTE_ID = p_inst_id;
        
        IF (I.C016 IS NULL) THEN
            SELECT LOWER(I.C013) ||'@'|| (SELECT LOWER(replace(INSTITUTE_NAME,chr(32),'')) FROM INSTITUTE_MST WHERE INSTITUTE_ID = AD.INSTITUTE_ID)  || '.com'
            INTO l_par_email
            FROM ADMISSION_APPLICATION AD 
            WHERE ADM_APPL_ID = l_get_appl_id
                AND INSTITUTE_ID = p_inst_id;
        END IF;
 
        UPDATE ADMISSION_APPLICATION
        SET STUD_EMAIL = l_stud_email
        WHERE ADM_APPL_ID = l_get_appl_id
            AND INSTITUTE_ID = p_inst_id;
 
---------------------------------CONFIRM STUDENT---------------------------------
        l_stud_utype := APP_UTIL.get_usertypeid_fromrole('STUD', p_inst_id);
 
        l_par_utype := APP_UTIL.get_usertypeid_fromrole('PAR', p_inst_id);
 
        SELECT COUNT(STUDENT_ID) INTO l_stud_cnt FROM STUDENTS_DET 
        WHERE FIRSTNAME = I.C002 
            AND MIDDLENAME = I.C003
            AND LASTNAME = I.C004
            AND INSTITUTE_ID = p_inst_id
            AND AC_YEAR_ID = p_aca_yr;
 
        SELECT COUNT(PARENTS_ID) INTO l_par_cnt FROM PARENTS_DET 
        WHERE FIRSTNAME = I.C013 
            AND MIDDLENAME = I.C014
            AND LASTNAME = I.C015
            AND INSTITUTE_ID = p_inst_id
            AND AC_YEAR_ID = p_aca_yr;
 
        SELECT NVL(((MAX(ROLL_NO) + 1)),1) INTO l_rno FROM STUDENTS_DET 
        WHERE CUR_MED = I.N001  
            AND CUR_STD = I.N002 
            --AND CUR_SEM = I.C049
            AND DIVISION_ID = I.C050
            AND INSTITUTE_ID = p_inst_id
            AND AC_YEAR_ID = p_aca_yr;
 
        IF(l_stud_cnt = 0 AND l_par_cnt = 0)THEN
            INSERT INTO USERS_MST(USER_ID,USERNAME,PASSWORD,FIRSTNAME,MIDDLENAME,LASTNAME,ACCOUNT_STATUS,
                        USER_TYPE_ID,MOBILENO,RECOVERY_EMAIL,INSTUTUTE_ID)
            VALUES(l_temp_uid, TRIM(l_stud_email), EMS_ENC_DEC.encrypt(I.C046), I.C002, I.C003, I.C004, 'Active',
                        l_stud_utype,I.C005, TRIM(l_stud_email), p_inst_id);
 
            INSERT INTO STUDENTS_DET(
                STUDENT_ID, ADM_APPL_CODE, ADMISSION_DT, ADMISSION_YEAR, ADM_MED, ADM_STD, ADM_SEM, INSTITUTE_ID,
                CUR_MED, CUR_STD, CUR_SEM, GR_NO, ROLL_NO, FIRSTNAME, MIDDLENAME, LASTNAME, DOB, AGE, GENDER,
                STUD_CONT_NO, STUD_MOBILE_NO, STUD_EMAIL, PERMNT_ADDR, PERMNT_CITY, PERMNT_STATE, PERMNT_COUNTRY, PERMNT_PINCODE,
                TEMP_ADDR, TEMP_CITY, TEMP_STATE, TEMP_COUNTRY, TEMP_PINCODE, FATHERNAME, FMIDDLENAME, FLASTNAME,
                FCONT_NO, FMOBILE_NO, FATHER_OCCUPATION, MOTHERNAME, MMIDDLENAME, MLASTNAME, MCONT_NO, MMOBILE_NO,
                MOTHER_OCCUPATION, STATUS, IS_GRADUATE, USER_ID, DIVISION_ID, ADM_APPL_ID, AC_YEAR_ID, ACADEMIC_STATUS)
            VALUES(
                STUDENTS_DET_SEQ.NEXTVAL, l_appl_code, TO_CHAR(TO_DATE(I.C045,'YYYY-MM-DD'),'MM/DD/YYYY'), (SELECT EXTRACT(YEAR FROM TO_DATE(I.C045,'YYYY-MM-DD')) FROM DUAL), I.N001, I.N002, I.C049, p_inst_id,
                I.N001, I.N002, I.C049, I.C001, l_rno, I.C002, I.C003, I.C004, TO_CHAR(TO_DATE(I.C006,'YYYY-MM-DD'),'MM/DD/YYYY'), I.C007, I.C008,
                I.C005, I.C005, l_stud_email, I.C031, I.C034, I.N003, I.N004, I.C035,
                I.C036, I.C039, I.N005, I.C048, I.C040, I.C013, I.C014, I.C015,
                I.C020, I.C020, I.C017, I.C025, I.C026, I.C027, I.C028, I.C028,
                I.C029, 'Active', I.C030, l_temp_uid, I.C050, l_get_appl_id, p_aca_yr, 'Active')
            RETURNING STUDENT_ID INTO l_stud_id;
 
            INSERT INTO USERS_MST(USER_ID,USERNAME,PASSWORD,FIRSTNAME,MIDDLENAME,LASTNAME,ACCOUNT_STATUS,
                USER_TYPE_ID,MOBILENO,RECOVERY_EMAIL,INSTUTUTE_ID)
            VALUES(l_temp_puid, NVL(TRIM(I.C016),l_par_email), EMS_ENC_DEC.encrypt(I.C047),I.C013,I.C014,I.C015,'Active',
                l_par_utype, I.C020, TRIM(I.C016),p_inst_id);
 
            INSERT INTO PARENTS_DET (
                PARENTS_ID, FIRSTNAME, MIDDLENAME, LASTNAME, ADDRESS, CITY, STATE, COUNTRY, PINCODE, MOBILENO, PHONENO, 
                OCCUPATION, POSITION, OFFICE_ADDRESS, OFFICEPHONE, OFFICEMOBILE, EXTENSIONNO, INSTITUTE_ID, USER_ID, AC_YEAR_ID, ACADEMIC_STATUS)
            VALUES (
                PARENTS_DET_SEQ.NEXTVAL, I.C013, I.C014, I.C015, I.C031, I.C034, I.N003, I.N004, I.C035, I.C020, I.C020,
                I.C017, I.C018, I.C021, I.C022, I.C024, I.C023, p_inst_id, l_temp_puid, p_aca_yr, 'Active')
            RETURNING PARENTS_ID INTO l_par_id;
 
            INSERT INTO STUD_PAR_MAP(MAP_ID_PK,STUDENT_ID_FK,PARENTS_ID_FK,INSTITUTE_ID)
            VALUES(STUD_PAR_MAP_SEQ.NEXTVAL, l_stud_id, l_par_id, p_inst_id);
 
        ELSIF(l_stud_cnt = 0 AND l_par_cnt = 1)THEN
        
            INSERT INTO USERS_MST(USER_ID,USERNAME,PASSWORD,FIRSTNAME,MIDDLENAME,LASTNAME,ACCOUNT_STATUS,
                        USER_TYPE_ID,MOBILENO,RECOVERY_EMAIL,INSTUTUTE_ID)
            VALUES(l_temp_uid, l_stud_email, EMS_ENC_DEC.encrypt(I.C046), I.C002, I.C003, I.C004, 'Active',
                        l_stud_utype,I.C005, l_stud_email, p_inst_id);
 
            INSERT INTO STUDENTS_DET(
                STUDENT_ID, ADM_APPL_CODE, ADMISSION_DT, ADMISSION_YEAR, ADM_MED, ADM_STD, ADM_SEM, INSTITUTE_ID,
                CUR_MED, CUR_STD, CUR_SEM, GR_NO, ROLL_NO, FIRSTNAME, MIDDLENAME, LASTNAME, DOB, AGE, GENDER,
                STUD_CONT_NO, STUD_MOBILE_NO, STUD_EMAIL, PERMNT_ADDR, PERMNT_CITY, PERMNT_STATE, PERMNT_COUNTRY, PERMNT_PINCODE,
                TEMP_ADDR, TEMP_CITY, TEMP_STATE, TEMP_COUNTRY, TEMP_PINCODE, FATHERNAME, FMIDDLENAME, FLASTNAME,
                FCONT_NO, FMOBILE_NO, FATHER_OCCUPATION, MOTHERNAME, MMIDDLENAME, MLASTNAME, MCONT_NO, MMOBILE_NO,
                MOTHER_OCCUPATION, STATUS, IS_GRADUATE, USER_ID, DIVISION_ID, ADM_APPL_ID, AC_YEAR_ID, ACADEMIC_STATUS)
            VALUES(
                STUDENTS_DET_SEQ.NEXTVAL, l_appl_code, TO_CHAR(TO_DATE(I.C045,'YYYY-MM-DD'),'MM/DD/YYYY'), (SELECT EXTRACT(YEAR FROM TO_DATE(I.C045,'YYYY-MM-DD')) FROM DUAL), I.N001, I.N002, I.C049, p_inst_id,
                I.N001, I.N002, I.C049, I.C001, l_rno, I.C002, I.C003, I.C004, TO_CHAR(TO_DATE(I.C006,'YYYY-MM-DD'),'MM/DD/YYYY'), I.C007, I.C008,
                I.C005, I.C005, l_stud_email, I.C031, I.C034, I.N003, I.N004, I.C035,
                I.C036, I.C039, I.N005, I.C048, I.C040, I.C013, I.C014, I.C015,
                I.C020, I.C020, I.C017, I.C025, I.C026, I.C027, I.C028, I.C028,
                I.C029, 'Active', I.C030, l_temp_uid, I.C050, l_get_appl_id, p_aca_yr, 'Active')
            RETURNING STUDENT_ID INTO l_stud_id;
 
            SELECT PARENTS_ID INTO l_par_id_found FROM PARENTS_DET
            WHERE FIRSTNAME = I.C013 
                AND MIDDLENAME = I.C014
                AND LASTNAME = I.C015
                AND INSTITUTE_ID = p_inst_id;
 
            INSERT INTO STUD_PAR_MAP(MAP_ID_PK,STUDENT_ID_FK,PARENTS_ID_FK,INSTITUTE_ID)
            VALUES(STUD_PAR_MAP_SEQ.NEXTVAL, l_stud_id, l_par_id_found, p_inst_id);
 
        END IF;
 
        UPDATE ADMISSION_APPLICATION
        SET ADMISSION_STATUS = 'Confirmed'
        WHERE ADM_APPL_ID = l_get_appl_id
            AND INSTITUTE_ID = p_inst_id;
 
    END LOOP;
 
    APEX_COLLECTION.TRUNCATE_COLLECTION(p_collection_name => 'STORE_ADMISSION');
 
    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception', 'EMS_UTIL.upload_admission_to_db');
END upload_admission_to_db;
 
-----------------------------Employees : Upload Collection data to Table(final step)---------------------------
procedure upload_employees_to_db (p_inst_id IN NUMBER)
IS
    l_temp_uid NUMBER(10);
    l_user_type NUMBER;
    l_emp_code VARCHAR2(10);
    l_emp_type NUMBER;
    l_state_id NUMBER;
    l_temp_state_id NUMBER;
    l_cntry_id NUMBER;
    l_temp_cntry_id NUMBER;
BEGIN
    FOR I IN (SELECT C001,C002,C003,C004,C005,C006,C007,C008,C009,C010,
            C011,C012,C013,C014,C015,C016,C017,C018,C019,C020,
            C021,C022,C023,C024,C025,C026,C027,C028,C029,C030
        FROM APEX_COLLECTIONS
        WHERE COLLECTION_NAME = 'STORE_EMPLOYEES')
    LOOP
        l_temp_uid := USERS_MST_SEQ.NEXTVAL;
 
        SELECT 'E' || TO_CHAR(EMPLOYEE_CODE.NEXTVAL, 'FM000') INTO l_emp_code
        FROM DUAL;
 
        SELECT TYPE_ID INTO l_emp_type
        FROM EMPLOYEE_TYPE_MST
        WHERE TYPE_NAME = I.C001;
 
        l_cntry_id := UPLOAD_FILE_PKG.get_country_id(I.C012);
        l_temp_cntry_id := UPLOAD_FILE_PKG.get_country_id(I.C017);
 
        l_state_id := UPLOAD_FILE_PKG.get_state_id(I.C011, l_cntry_id);
        l_temp_state_id := UPLOAD_FILE_PKG.get_state_id(I.C016, l_temp_cntry_id);
 
        l_user_type := APP_UTIL.get_usertypeid_fromrole('EMP', p_inst_id);
 
        INSERT INTO USERS_MST(USER_ID, USERNAME, PASSWORD, FIRSTNAME, MIDDLENAME, LASTNAME, ACCOUNT_STATUS,
            USER_TYPE_ID, MOBILENO, RECOVERY_EMAIL, INSTUTUTE_ID)
        VALUES(l_temp_uid, TRIM(I.C027), EMS_ENC_DEC.encrypt(I.C028), I.C002, I.C003, I.C004,'Active',
            l_user_type, I.C019, TRIM(I.C027), p_inst_id);
 
        INSERT INTO EMPLOYEE_DET(
            EMPLOYEE_ID, USER_ID, INSTITUTE_ID, EMPLOYEE_TYPE_ID, EMPLOYEE_CODE, FIRSTNAME, MIDDLENAME, LASTNAME,
            DOB, AGE, GENDER, MARITIAL_STATUS, ADDRESS, CITY, STATE_ID, COUNTRY_ID, ZIPCODE,
            TEMP_ADD, TEMP_CITY, TEMP_STATE_ID, TEMP_COUNTRY_ID, TEMP_ZIP, EMAILID, CONTNO, MOBILENO,
            BLOODGROUP, HEALT_STATUS, JOB_PROFILE_TITLE, "JOINNING DATE", JOB_TITLE, DEPARTMENT, POSITION)
        VALUES(
            EMPLOYEE_DET_SEQ.NEXTVAL, l_temp_uid, p_inst_id, l_emp_type, l_emp_code, I.C002, I.C003, I.C004,
            TO_CHAR(TO_DATE(I.C005,'YYYY-MM-DD'),'MM/DD/YYYY'), I.C006, I.C007, I.C008, I.C009, I.C010, l_state_id, l_cntry_id, I.C013,
            I.C014, I.C015, l_temp_state_id, l_temp_cntry_id, I.C018, I.C027, I.C019, I.C019,
            I.C020, I.C021, I.C022, TO_CHAR(TO_DATE(I.C023,'YYYY-MM-DD'),'MM/DD/YYYY'), I.C024, I.C025, I.C026);
    END LOOP;
    
    APEX_COLLECTION.TRUNCATE_COLLECTION (p_collection_name => 'STORE_EMPLOYEES');
 
    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception', 'EMS_UTIL.upload_employees_to_db');
END upload_employees_to_db;
 
-----------------------------Assign Subjects : Upload Collection data to Table(final step)---------------------------
procedure upload_ass_subjects_to_db (p_inst_id IN NUMBER, p_aca_yr IN NUMBER)
IS
BEGIN
    FOR I IN (SELECT C001,C002,C003,C004,C005,C006,C007,C008,C009,C010,
            C011,C012,C013
        FROM APEX_COLLECTIONS
        WHERE COLLECTION_NAME = 'STORE_ASSIGN_SUBJECTS')
    LOOP
        INSERT INTO ASSIGN_SUB_DET(ASSIGN_ID, EMPLOYEE_ID, MED_ID, STD_ID, SEM_ID, DIV_ID, SUB_ID, AC_YEAR_ID, INSTITUTE_ID, DETAILS, STATUS)
        VALUES(ASSIGN_SUB_DET_SEQ.NEXTVAL, I.C008, I.C009, I.C010, I.C011, I.C012, I.C013, p_aca_yr, p_inst_id, I.C007, 'Active');
    END LOOP;
 
    APEX_COLLECTION.TRUNCATE_COLLECTION (p_collection_name => 'STORE_ASSIGN_SUBJECTS');
 
    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception', 'EMS_UTIL.upload_ass_subjects_to_db');
END upload_ass_subjects_to_db;
 
-----------------------------------------Hostel : Assign Room-------------------------------------
procedure hostel_assign_room (p_hostel_id IN NUMBER, p_room_id IN NUMBER, p_stud_id IN VARCHAR2, p_status IN VARCHAR2, p_inst_id IN NUMBER,p_ac_yr IN NUMBER)
IS
    l_assigned_room NUMBER;
    l_capacity NUMBER;
    l_selected_stud NUMBER;
    l_avail NUMBER;
    l_avail_capacity NUMBER;
    l_allocated NUMBER;
BEGIN
    SELECT CAPACITY INTO l_capacity 
    FROM HOSTEL_ROOM_MST 
    WHERE ROOM_ID = p_room_id 
        AND HOSTEL_ID = p_hostel_id 
        AND INSTITUTE_ID = p_inst_id;
 
    SELECT COUNT(ROOM_ID) INTO l_assigned_room 
    FROM HOSTEL_ROOM_ASSIGN_DET 
    WHERE ROOM_ID = p_room_id 
        AND HOSTEL_ID = p_hostel_id 
        AND INSTITUTE_ID = p_inst_id;
 
    SELECT COUNT(*) INTO l_selected_stud FROM table (apex_string.split_numbers(p_stud_id,':'));
 
    l_avail := l_capacity - l_assigned_room;
 
    IF(l_assigned_room <= l_capacity) THEN
        IF(l_selected_stud <= l_avail) THEN
            FOR i IN (SELECT * FROM table (apex_string.split_numbers(p_stud_id,':')))
            LOOP
                INSERT INTO HOSTEL_ROOM_ASSIGN_DET(
                    ROOM_ASSIGN_ID, STUDENT_ID, ROOM_ID, HOSTEL_ID,
                    AC_YEARID, STATUS, INSTITUTE_ID)
                VALUES(
                    HOSTEL_ROOM_ASSIGN_DET_SEQ.NEXTVAL, i.COLUMN_VALUE, p_room_id, p_hostel_id,
                    p_ac_yr, p_status, p_inst_id);
            END LOOP;
 
            --After allocation check the avail capacity and update the tbl with latest availibility of rooms..
            SELECT COUNT(ROOM_ID) INTO l_allocated 
            FROM HOSTEL_ROOM_ASSIGN_DET 
            WHERE ROOM_ID = p_room_id 
                AND HOSTEL_ID = p_hostel_id;
 
            l_avail_capacity := l_capacity - l_allocated;
 
            UPDATE HOSTEL_ROOM_MST 
            SET AVAILABILITY = l_avail_capacity
            WHERE HOSTEL_ID = p_hostel_id 
                AND ROOM_ID = p_room_id;
        ELSE
            UPDATE HOSTEL_ROOM_MST 
            SET AVAILABILITY = 0
            WHERE HOSTEL_ID = p_hostel_id 
                AND ROOM_ID = p_room_id;
                
            APEX_ERROR.ADD_ERROR (
                p_message  => 'No of students selected is more than availability..Please check "Availability" field and select again!!!',
                p_display_location => apex_error.c_inline_in_notification);
        END IF;       
    ELSE 
        APEX_ERROR.ADD_ERROR (
            p_message  => 'Room Capacity is Full!',
            p_display_location => apex_error.c_inline_in_notification);
    END IF;
END hostel_assign_room;
 
-----------------------------------------Transportation : Assign Vehicle to Student-------------------------------------
procedure assign_vehicle(p_vehicle_id IN NUMBER, p_trans_code IN VARCHAR2, p_point_id IN NUMBER, p_stud_id IN VARCHAR2, p_inst_id IN NUMBER)
IS
    l_allocated NUMBER;
    l_capacity NUMBER;
    l_selectd_stud NUMBER;
    l_avail NUMBER;
BEGIN
    SELECT VEHICAL_CAPACITY INTO l_capacity  --7
    FROM VEHICAL_MST 
    WHERE VEHICAL_ID = p_vehicle_id 
        AND INSTITUTE_ID = p_inst_id;
 
    SELECT COUNT(TRANSPORT_ID) INTO l_allocated  --0
    FROM TRANSPORT_DET 
    WHERE VEHICAL_ID = p_vehicle_id;
 
    SELECT COUNT(*)  --3
    INTO l_selectd_stud 
    FROM table (apex_string.split_numbers(p_stud_id,':'));
 
    l_avail := l_capacity - l_allocated; --7 - 0 = 7
 
    IF(l_allocated <= l_capacity) THEN  -- 0 <= 7 TRUE
        IF(l_selectd_stud <= l_avail) THEN  -- 5 <= 7 TRUE
            FOR I in (SELECT * FROM table (apex_string.split_numbers(p_stud_id,':'))) --5 times loop
            LOOP
                INSERT INTO TRANSPORT_DET(TRANSPORT_ID, TRANSPORT_CODE, STUDENT_ID, POINT_ID, VEHICAL_ID)
                VALUES(TRANSPORT_DET_SEQ.NEXTVAL, p_trans_code, I.COLUMN_VALUE, p_point_id, p_vehicle_id);
            END LOOP;
        ELSE
            APEX_ERROR.ADD_ERROR (
                p_message  => 'No of Students selected is more than capacity..Please select again!!!',
                p_display_location => apex_error.c_inline_in_notification); 
        END IF;       
    ELSE 
        APEX_ERROR.ADD_ERROR (
            p_message  => 'Vehical Capacity is Full!',
            p_display_location => apex_error.c_inline_in_notification);
    END IF;
END assign_vehicle;

-----------------------------------------Create User Roles-------------------------------------
procedure create_user_roles(p_inst_id IN NUMBER)
IS
BEGIN
	INSERT INTO USERS_TYPE_MST(USER_TYPE_NAME, USER_TYPE_CODE, INSTITUTE_ID)
    VALUES('ADMIN', 'ADM', p_inst_id);

    INSERT INTO USERS_TYPE_MST(USER_TYPE_NAME, USER_TYPE_CODE, INSTITUTE_ID)
    VALUES('EMPLOYEE', 'EMP', p_inst_id);

    INSERT INTO USERS_TYPE_MST(USER_TYPE_NAME, USER_TYPE_CODE, INSTITUTE_ID)
    VALUES('STUDENT', 'STUD', p_inst_id);

    INSERT INTO USERS_TYPE_MST(USER_TYPE_NAME, USER_TYPE_CODE, INSTITUTE_ID)
    VALUES('PARENT', 'PAR', p_inst_id);
END create_user_roles;

END EMS_UTIL;

/
