--------------------------------------------------------
--  DDL for Package Body EMS_MAIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."EMS_MAIL" is

procedure registration_mail (p_appl_code in number,p_institute_id in number,p_stud_id in number,p_acyr_id in number)
is
        ADM_CODE varchar2(25);
        STUD_NM varchar2(80);
        ACA_YR varchar2(30);
        INST_NM VARCHAR2(100);
        INT_LOGO BLOB;
        PAR_EMAIL VARCHAR2(100);
        INST_EMAIL VARCHAR2(100);
        EFLAG VARCHAR2(5);
        URL VARCHAR2(1000);
        PHNO VARCHAR2(30);
   BEGIN
        SELECT USERNAME INTO PAR_EMAIL FROM USERS_MST
        WHERE USER_ID = (SELECT PD.USER_ID 
                    FROM STUDENTS_DET SD,PARENTS_DET PD,STUD_PAR_MAP SM
                    WHERE SM.STUDENT_ID_FK = SD.STUDENT_ID AND 
                    SM.PARENTS_ID_FK = PD.PARENTS_ID AND 
                    SD.STUDENT_ID = p_stud_id AND
                    SD.INSTITUTE_ID = p_institute_id AND
                    PD.INSTITUTE_ID = p_institute_id AND
                    SD.AC_YEAR_ID = p_acyr_id AND
                    PD.AC_YEAR_ID = p_acyr_id);

        SELECT INST_LOGO,INSTITUTE_NAME,EMAIL,EMAIL_FLAG,WEB_URL,TEL_PHONE_NO 
        INTO INT_LOGO,INST_NM,INST_EMAIL,EFLAG,URL,PHNO
        FROM INSTITUTE_MST 
        WHERE INSTITUTE_ID = p_institute_id;

        SELECT YEAR_NAME INTO ACA_YR FROM ACADEMIC_YEAR_MST WHERE AC_YEAR_ID = p_acyr_id;

        SELECT ADM_APPL_CODE, 
                FIRSTNAME || ' ' || MIDDLENAME || ' ' || LASTNAME
        into ADM_CODE,STUD_NM
        FROM ADMISSION_APPLICATION
        WHERE ADM_APPL_ID = p_appl_code 
            AND INSTITUTE_ID = p_institute_id
            AND AC_YEAR_ID = p_acyr_id;

        IF(EFLAG = 'Y')THEN
            apex_mail.send (
            p_from               => INST_EMAIL,
            p_to                 => PAR_EMAIL,
            p_cc                 => 'admin@gmail.com',
            p_template_static_id => 'AdmissionConfirm',
            p_placeholders       => '{' ||
            '    "ADM_APPL_CODE":'  || apex_json.stringify( ADM_CODE ) ||
            '   ,"INSTITUTE_NAME":' || apex_json.stringify( INST_NM ) ||
            '   ,"STUD_NAME":'      || apex_json.stringify( STUD_NM ) ||
            --'   ,"INST_LOGO":'      || apex_json.stringify(INT_LOGO) ||
            '   ,"AC_YEAR_ID":'     || apex_json.stringify( ACA_YR ) ||
            '   ,"WEB_URL":'     || apex_json.stringify( URL ) ||
            '   ,"TEL_PHONE_NO":'     || apex_json.stringify( PHNO ) ||
            '}' );
            
            apex_mail.push_queue;   
        END IF;
END registration_mail;

---------------------------------------EVENT MAIL----------------------------------------------------------------
procedure event_mail(p_institute_id in number,p_event_id number)
is 
    INT_LOGO BLOB;
    INST_NM VARCHAR2(100);
    INST_EMAIL VARCHAR2(100);
    INST_URL VARCHAR2(70);
    INST_TEL NUMBER;
    EFLAG VARCHAR2(5);
    EVE_TYP VARCHAR2(100);
    EVE_DET VARCHAR2(1000);
    EVE_DATE DATE;
BEGIN
    SELECT INST_LOGO,INSTITUTE_NAME,EMAIL,WEB_URL,TEL_PHONE_NO,EMAIL_FLAG 
    INTO INT_LOGO,INST_NM,INST_EMAIL,INST_URL,INST_TEL,EFLAG
    FROM INSTITUTE_MST
    WHERE INSTITUTE_ID = p_institute_id;

    SELECT (SELECT EVENT_TYPE FROM EVENT_TYPE_MST WHERE EVENT_ID = INSTITUTE_CALENDAR.EVENT_TYPE),EVENT_DETAILS,CAL_DATE
    INTO EVE_TYP, EVE_DET,EVE_DATE
    FROM INSTITUTE_CALENDAR
    WHERE INSTITUTE_ID = p_institute_id AND
        CAL_ID = p_event_id;

    IF(EFLAG = 'Y')THEN
        FOR I IN (SELECT USERNAME FROM USERS_MST WHERE USER_TYPE_ID IN(61, 62, 70))
        LOOP
            apex_mail.send (
            p_from               => INST_EMAIL,
            p_to                 => I.USERNAME,
            p_template_static_id => 'EventMail',
            p_placeholders       => '{' ||
            '   ,"INSTITUTE_NAME":' || apex_json.stringify(INST_NM) ||
            '   ,"WEB_URL":' || apex_json.stringify(INST_URL) ||
            '   ,"TEL_PHONE_NO":' || apex_json.stringify(INST_TEL) ||
            '   ,"EVENT_TYPE":' || apex_json.stringify(EVE_TYP) ||
            '   ,"EVENT_DETAILS":' || apex_json.stringify(EVE_DET) ||
            '   ,"CAL_DATE":' || apex_json.stringify(EVE_DATE) ||
            --'   ,"INST_LOGO":'      || apex_json.stringify(INT_LOGO) ||
            '}' );
        END LOOP;

        apex_mail.push_queue;
    END IF;
END event_mail;
-----------------------------------INTERNAL MAIL--------------------------------------------------------------------
procedure internal_mail(p_institute_id in number,p_email_id in number)
is
    INT_LOGO BLOB;
    INST_NM VARCHAR2(100);
    INST_EMAIL VARCHAR2(100);
    EFLAG VARCHAR2(5);
    SEN VARCHAR2(200);
    REV VARCHAR2(200);
    SUB VARCHAR2(200);
    MAT VARCHAR2(200);
    EDATE DATE;
BEGIN
    SELECT INST_LOGO,INSTITUTE_NAME,EMAIL_FLAG INTO INT_LOGO,INST_NM,EFLAG
    FROM INSTITUTE_MST 
    WHERE INSTITUTE_ID = p_institute_id;

    SELECT SENDER,RECEIVER,SUBJECT,MATTER,EMAIL_DATE
    INTO SEN,REV,SUB,MAT,EDATE
    FROM TMS.EMS_EMAIL
    WHERE EMAIL_PK = p_email_id
        AND INSTITUTE_ID = p_institute_id;

    IF(EFLAG = 'Y')THEN
        apex_mail.send (
            p_from               => SEN,
            p_to                 => REV,
            p_template_static_id => 'InternalMail',
            p_placeholders       => '{' ||
            '   ,"INSTITUTE_NAME":' || apex_json.stringify(INST_NM) ||
            '   ,"SENDER":' || apex_json.stringify(SEN) ||
            '   ,"RECEIVER":' || apex_json.stringify(REV) ||
            '   ,"SUBJECT":' || apex_json.stringify(SUB) ||
            '   ,"MATTER":' || apex_json.stringify(MAT) ||
            '   ,"EMAIL_DATE":' || apex_json.stringify(EDATE) ||
            --'   ,"INST_LOGO":'      || apex_json.stringify(INT_LOGO) ||
            '}' );
        apex_mail.push_queue;
    END IF;
END internal_mail;

-----------------------------------------SCHOOL INTRO MAIL--------------------------------------------------------------

procedure school_intro_mail(p_institute_id in number, p_stud_id in number,p_acyr_id in number)
IS 
    INT_LOGO BLOB;
    INST_NM VARCHAR2(100);
    INST_EMAIL VARCHAR2(100);
    INST_URL VARCHAR2(70);
    INST_TEL NUMBER;
    EFLAG VARCHAR2(5);
    PAR_EMAIL VARCHAR2(100);
    STUD_EMAIL VARCHAR2(100);
BEGIN
    SELECT INST_LOGO,INSTITUTE_NAME,EMAIL,WEB_URL,TEL_PHONE_NO,EMAIL_FLAG
    INTO INT_LOGO,INST_NM,INST_EMAIL,INST_URL,INST_TEL,EFLAG
    FROM INSTITUTE_MST
    WHERE INSTITUTE_ID = p_institute_id;

    SELECT USERNAME INTO PAR_EMAIL FROM USERS_MST
        WHERE USER_ID = (SELECT PD.USER_ID 
                    FROM STUDENTS_DET SD,PARENTS_DET PD,STUD_PAR_MAP SM
                    WHERE SM.STUDENT_ID_FK = SD.STUDENT_ID AND 
                    SM.PARENTS_ID_FK = PD.PARENTS_ID AND 
                    SD.STUDENT_ID = p_stud_id AND
                    SD.INSTITUTE_ID = p_institute_id AND
                    PD.INSTITUTE_ID = p_institute_id AND
                    SD.AC_YEAR_ID = p_acyr_id AND
                    PD.AC_YEAR_ID = p_acyr_id);

    SELECT USERNAME INTO STUD_EMAIL FROM USERS_MST
        WHERE USER_ID = (SELECT SD.USER_ID 
                    FROM STUDENTS_DET SD,PARENTS_DET PD,STUD_PAR_MAP SM
                    WHERE SM.STUDENT_ID_FK = SD.STUDENT_ID AND 
                    SM.PARENTS_ID_FK = PD.PARENTS_ID AND 
                    SD.STUDENT_ID = p_stud_id AND
                    SD.INSTITUTE_ID = p_institute_id AND
                    PD.INSTITUTE_ID = p_institute_id AND
                    SD.AC_YEAR_ID = p_acyr_id AND
                    PD.AC_YEAR_ID = p_acyr_id);

    IF(EFLAG = 'Y')THEN
        apex_mail.send (
            p_from               => INST_EMAIL,
            p_to                 => PAR_EMAIL,
            p_template_static_id => 'SchoolIntroMail',
            p_placeholders       => '{' ||
            '   ,"INSTITUTE_NAME":' || apex_json.stringify(INST_NM) ||
            '   ,"EMAIL":' || apex_json.stringify(INST_EMAIL) ||
            '   ,"WEB_URL":' || apex_json.stringify(INST_URL) ||
            '   ,"TEL_PHONE_NO":' || apex_json.stringify(INST_TEL) ||
            --'   ,"INST_LOGO":'      || apex_json.stringify(INT_LOGO) ||
            '}' );

        apex_mail.push_queue;
    END IF;
END school_intro_mail;

-------------------------------------------------------------------------------------------------------

procedure test_assigned_mail (p_test in varchar2, p_std_id in number,p_acyr_id in number)
is 
    v_student varchar2(1000);
    BEGIN
        FOR c1 in (SELECT  TEST_PK,USER_NM, TEST_NAME, DESCRIPTION, TEST_TYPE, NO_OF_QUE, TEST_GEN_DATE, DURATION, TEST_AVAILABILITY, PASSING_PERCENT,
                    (SELECT SUBJECT_NAME FROM SUBJECT_MST WHERE SUB_ID = ET.SUB_ID) AS SUB_ID,
                    (SELECT STD_NAME FROM STANDARD_MST WHERE STD_ID = ET.STD_ID) AS STD_ID
                    FROM TMS.EMS_TEST ET
                    WHERE TEST_PK = p_test and STD_ID = p_std_id
                        AND ET.AC_YEAR_ID = p_acyr_id)
        LOOP
            for i in(SELECT STUD_EMAIL FROM STUDENTS_DET WHERE CUR_STD = p_std_id)
            loop
                apex_mail.send (
                p_to                 => i.STUD_EMAIL,
                p_from               => 'grimapatel98@gmail.com',
                p_template_static_id => 'TESTASSIGNEDMAIL',
                p_placeholders       => '{' ||
                '    "DESCRIPTION":'       || apex_json.stringify( c1.DESCRIPTION ) ||
                '   ,"DURATION":'          || apex_json.stringify( c1.DURATION ) ||
                '   ,"PASSING_PERCENT":'   || apex_json.stringify( c1.PASSING_PERCENT ) ||
                '   ,"STD_ID":'            || apex_json.stringify( c1.STD_ID ) ||
                '   ,"SUB_ID":'            || apex_json.stringify( c1.SUB_ID ) ||
                '   ,"TEST_AVAILABILITY":' || apex_json.stringify( c1.TEST_AVAILABILITY ) ||
                '   ,"TEST_GEN_DATE":'     || apex_json.stringify( c1.TEST_GEN_DATE ) ||
                '   ,"TEST_NAME":'         || apex_json.stringify( c1.TEST_NAME ) ||
                '   ,"TEST_TYPE":'         || apex_json.stringify( c1.TEST_TYPE ) ||
                '   ,"USER_NM":'           || apex_json.stringify( c1.USER_NM ) ||
                '}' );
            end loop;
        END LOOP;
END test_assigned_mail;

---------------------------------------------------------------------------------------------------------------------
procedure test_results_mail(p_test_id in number, p_user_id in number, p_acyr_id in number)
is 
    uid number;
    BEGIN

        SELECT USER_ID INTO uid FROM USERS_MST WHERE UPPER(USERNAME) = UPPER(p_user_id);

        FOR r1 in (SELECT USER_ID,
                (SELECT USER_NM FROM TMS.EMS_TEST WHERE TEST_PK = EI.TEST_FK AND TEST_PK = p_test_id) as USER_NM,
                (SELECT TEST_NAME FROM TMS.EMS_TEST WHERE TEST_PK = EI.TEST_FK) AS TEST_NAME,
                (SELECT STD_NAME FROM STANDARD_MST WHERE STD_ID = EI.STD_ID) AS STD_ID,
                (SELECT FIRSTNAME || ' ' ||MIDDLENAME || ' ' ||LASTNAME FROM STUDENTS_DET WHERE STUDENT_ID = EI.STUDENT_ID) AS STUD_NAME,		
                NO_OF_CORRECT, NO_OF_INCORRECT, SCORE,
                decode(result,1,'PASS',2,'FAIL')"RESULT",
                ROUND(((SCORE/(SELECT COUNT(QID_FK) FROM TMS.EMS_TEST_QUES WHERE TEST_FK = EI.TEST_FK)) * 100),2) AS PERC
                FROM TMS.EMS_TEST_INFO EI
                WHERE USER_ID = uid and 
                    TEST_FK = p_test_id
                    AND EI.AC_YEAR_ID = p_acyr_id)
        LOOP
            FOR r in (SELECT STUD_EMAIL FROM STUDENTS_DET WHERE USER_ID = p_user_id)
            loop
                apex_mail.send (
                p_to                 => r.STUD_EMAIL,
                p_from               => 'grimapatel98@gmail.com',
                p_template_static_id => 'TESTRESULTMAIL',
                p_placeholders       => '{' ||
                '    "NO_OF_CORRECT":'   || apex_json.stringify( r1.NO_OF_CORRECT ) ||
                '   ,"NO_OF_INCORRECT":' || apex_json.stringify( r1.NO_OF_INCORRECT ) ||
                '   ,"PERCENTAGE":'      || apex_json.stringify( r1.PERC ) ||
                '   ,"RESULT":'          || apex_json.stringify( r1.RESULT ) ||
                '   ,"SCORE":'           || apex_json.stringify( r1.SCORE ) ||
                '   ,"STUD_NM":'         || apex_json.stringify( r1.STUD_NAME ) ||
                '   ,"TEST_NAME":'       || apex_json.stringify( r1.TEST_NAME ) ||
                '   ,"USER_NM":'         || apex_json.stringify( r1.USER_NM ) ||
                '}' );
            end loop;
        END LOOP;
END test_results_mail;

--------------------------------------------------------------------------------------------------------

-- SELECT to_CHAR(TEST_AVAILABILITY - 1, 'DD-MON-YYYY') FROM TMS.EMS_TEST WHERE TEST_PK = 114
--------------------------------------------------------------------------------------------------------

procedure fees_mail(p_stud_id in number, p_fees_type in number, p_inst in number, p_acyr_id in number)
is 
    email varchar2(50);
    receipt varchar2(50);
    feedt varchar2(20);
    sem varchar2(30);
    std varchar2(30);
    studnm varchar2(90);
    total number;
    dis number;
    charge number;
    instnm varchar2(70);
    BEGIN
        SELECT SD.STUD_EMAIL, SF.RECEIPT_NO, TO_CHAR(SF.FEES_DATE,'DD-MON-YYYY'), 
            (SELECT SEM_NAME FROM SEMESTER_MST WHERE SEM_ID = SF.SEM_ID), 
            (SELECT STD_NAME FROM STANDARD_MST WHERE STD_ID = SF.STD_ID), 
            (SELECT FIRSTNAME || ' ' || MIDDLENAME || ' ' || LASTNAME FROM STUDENTS_DET WHERE STUDENT_ID = SF.STUDENT_ID), 
            SF.TOTAL_AMT, SF.DISCOUT_AMT, SF.CHARGE_AFTER_DUE_DT, 
            (SELECT INSTITUTE_NAME FROM INSTITUTE_MST WHERE INSTITUTE_ID = SF.INSTITUTE_ID)
        INTO email, receipt, feedt, sem, std, studnm, total, dis, charge, instnm
        FROM STUDENT_FEES_DET SF, STUDENTS_DET SD
        WHERE SF.STUDENT_ID = SD.STUDENT_ID
            AND SF.STUDENT_ID = p_stud_id
            AND SF.FEES_TYPE_ID = p_fees_type
            AND SF.INSTITUTE_ID = p_inst
            AND SF.AC_YEAR_ID = p_acyr_id;

        apex_mail.send (
        p_to                 => email,
        p_from               => 'grimapatel98@gmail.com',
        p_template_static_id => 'FEESMAIL',
        p_placeholders       => '{' ||
        '    "CHARGE_AFTER_DUE_DT":' || apex_json.stringify( charge ) ||
        '   ,"DISCOUNT_AMT":'        || apex_json.stringify( dis ) ||
        '   ,"FEES_DATE":'           || apex_json.stringify( feedt ) ||
        '   ,"INSTITUTE_ID":'        || apex_json.stringify( instnm ) ||
        '   ,"RECEIPT_NO":'          || apex_json.stringify( receipt ) ||
        '   ,"SEM_ID":'              || apex_json.stringify( sem ) ||
        '   ,"STD_ID":'              || apex_json.stringify( std ) ||
        '   ,"STUD_NM":'             || apex_json.stringify( studnm ) ||
        '   ,"TOTAL_AMT":'           || apex_json.stringify( total ) ||
        '}' );
       
END fees_mail;

------------------------------------------------------------------------------------------------------------
--ATTENDANCE MAIL--
/*
WITH RWS AS (
    SELECT DISTINCT STUDENT_ID,
        (SELECT ROLL_NO FROM STUDENTS_DET WHERE STUDENT_ID = AT_STUD_ATTENDANCE.STUDENT_ID) AS ROLLNO,
        (SELECT FIRSTNAME || ' ' || MIDDLENAME || ' ' || LASTNAME FROM STUDENTS_DET 
        WHERE STUDENT_ID = AT_STUD_ATTENDANCE.STUDENT_ID) AS STUDENT_NAME,
        COUNT(SCHEDULE_ID_FK) AS TOTAL_LEC,
        ATTEND_STATUS
    FROM AT_STUD_ATTENDANCE
    WHERE STD_ID = :P3016_STD_ID_1 AND
        SEM_ID = :P3016_SEM_ID_1 AND
        DIV_ID = :P3016_DIV_ID_1
    GROUP BY ATTEND_STATUS,STUDENT_ID
)
(
    SELECT * FROM RWS
    PIVOT (COUNT(STUDENT_ID) FOR ATTEND_STATUS IN ('P','A'))
)
*/

END EMS_MAIL;

/
