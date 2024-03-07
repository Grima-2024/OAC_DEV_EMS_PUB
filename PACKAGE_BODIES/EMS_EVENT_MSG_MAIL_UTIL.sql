--------------------------------------------------------
--  DDL for Package Body EMS_EVENT_MSG_MAIL_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."EMS_EVENT_MSG_MAIL_UTIL" IS

-------------------------------------Create Event------------------------------------
procedure create_event(
    p_repeat_on IN CHAR,
    p_start_date IN VARCHAR2,
    p_end_date IN VARCHAR2,
    p_event_type IN NUMBER,
    p_event_details IN VARCHAR2,
    p_inst_id IN NUMBER,
    p_acyr_id IN NUMBER
)
IS
    l_start_date DATE:= to_date(p_start_date,'DD-MON-YYYY') - 1;
    l_end_date DATE:= to_date(p_end_date,'DD-MON-YYYY') + 1;
    l_mstart_date DATE:= to_date(p_start_date,'DD-MON-YYYY');
    l_mend_date DATE:= to_date(p_end_date,'DD-MON-YYYY');
    l_start_day VARCHAR2(20);
    l_start_date_day VARCHAR2(20);
    l_monthly VARCHAR2(20);
    l_yearly VARCHAR2(20);
    l_cal_id NUMBER;
BEGIN
	--Check how frequetly user wants to repeat the Event..
    IF (p_repeat_on = 's') THEN		--Single Day event

        INSERT INTO INSTITUTE_CALENDAR (CAL_ID, CAL_DATE, EVENT_TYPE, EVENT_DETAILS, INSTITUTE_ID, AC_YEAR_ID)
        VALUES(INSTITUTE_CALENDAR_SEQ.NEXTVAL, to_date(p_start_date,'DD-MON-YYYY'), p_event_type, p_event_details, p_inst_id, p_acyr_id)
        RETURNING CAL_ID INTO l_cal_id;

    ELSIF (p_repeat_on = 'd')THEN 	--Daily Event
        --Loop through Dates starting from Start Date uptill End Date..
		LOOP
           l_start_date := l_start_date + 1; --Increment the date by 1

			--Check Start date is less then End Date..
            IF l_start_date < l_end_date THEN 
               SELECT TO_CHAR(l_start_date,'DAY') INTO l_start_day FROM DUAL;  	--Fetch Day of Date

                IF (TRIM(l_start_day) = 'SUNDAY') THEN 		--If it is Sunday then dont create any event..
                    SYS.HTP.P('WEEKEND--Do nothing');
                ELSE 	--Else create event for dates specified..
                    INSERT INTO INSTITUTE_CALENDAR (CAL_ID, CAL_DATE, EVENT_TYPE, EVENT_DETAILS, INSTITUTE_ID, AC_YEAR_ID)
                    VALUES(INSTITUTE_CALENDAR_SEQ.NEXTVAL, l_start_date, p_event_type, p_event_details, p_inst_id, p_acyr_id)
                    RETURNING CAL_ID INTO l_cal_id;
                END IF;
            ELSE 
                EXIT;
            END IF;
        END LOOP;
 
    ELSIF(p_repeat_on = 'w')THEN 	--Weekly Event
        SELECT TO_CHAR(l_start_date,'DAY') INTO l_start_date_day FROM DUAL;  --Fetch Day of Start Date
        LOOP
            l_start_date := l_start_date + 7; --Increment the date by 7 to create weekly event
            
			--Check Start date is less then End Date..
			IF l_start_date < l_end_date THEN
                SELECT TO_CHAR(l_start_date,'DAY') INTO l_start_day FROM DUAL; --Fetch Day of Date
            ELSE
                EXIT;
            END IF;
 
            FOR i IN 1..1
            LOOP
				--Compare day of Start Date and loop date to create event on that particular day...
				--eg: Start Date Day is Friday then check for Friday again and if it matches then create event..
                IF(trim(l_start_date_day) = trim(l_start_day)) THEN 
                    
                    INSERT INTO INSTITUTE_CALENDAR (CAL_ID, CAL_DATE, EVENT_TYPE, EVENT_DETAILS, INSTITUTE_ID, AC_YEAR_ID)
                    VALUES(INSTITUTE_CALENDAR_SEQ.NEXTVAL, l_start_date, p_event_type, p_event_details, p_inst_id, p_acyr_id)
                    RETURNING CAL_ID INTO l_cal_id;

                END IF;
            END LOOP;
        END LOOP;
   
    ELSIF(p_repeat_on = 'm')THEN 	--Monthly Event
        LOOP
			--Check Start date is less then End Date..
            IF l_mstart_date < l_mend_date THEN 

				--Add 1 month to Start date to create monthly event on same date for next month..
				--eg: Start Date : 18-May-2023 ...then 18-May-2023 + 1 = 18-Jun-2023 so next event will be created on 18-Jun-2023
                SELECT ADD_MONTHS(to_date(p_start_date,'DD-MON-YYYY'),1) INTO l_monthly FROM DUAL;
                    
                INSERT INTO INSTITUTE_CALENDAR (CAL_ID, CAL_DATE, EVENT_TYPE, EVENT_DETAILS, INSTITUTE_ID, AC_YEAR_ID)
                VALUES(INSTITUTE_CALENDAR_SEQ.NEXTVAL, l_mstart_date, p_event_type, p_event_details, p_inst_id, p_acyr_id)
                RETURNING CAL_ID INTO l_cal_id;

                l_mstart_date := add_months(l_mstart_date,1); 
            ELSE  
                EXIT;
            END IF;
        END LOOP;

    ELSIF(p_repeat_on = 'y')THEN 	--Year Event
        LOOP
			--Check Start date is less then End Date..
            IF l_mstart_date < l_mend_date THEN
                
				--Add 12 to Start date(month) to create yearly event on same date for next year..
				--eg: Start Date : 18-May-2023...then 18-May-2023 + 12 = 18-May-2024 so next event will be created on 18-Jun-2024
				SELECT ADD_MONTHS(to_date(p_start_date,'DD-MON-YYYY'),12) INTO l_yearly FROM DUAL;

                INSERT INTO INSTITUTE_CALENDAR (CAL_ID, CAL_DATE, EVENT_TYPE, EVENT_DETAILS, INSTITUTE_ID, AC_YEAR_ID)
                VALUES(INSTITUTE_CALENDAR_SEQ.NEXTVAL, l_mstart_date, p_event_type, p_event_details, p_inst_id, p_acyr_id)
                RETURNING CAL_ID INTO l_cal_id;

                l_mstart_date := add_months(l_mstart_date,12); 
            ELSE
                EXIT;
            END IF;
        END LOOP;
    END IF;

    -----------------SEND EMAIL--------------------
    --EMS_MAIL.event_mail(p_inst_id, l_cal_id);

    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception in Event Creation');
END create_event;

-------------------------------------Delete Event------------------------------------
procedure delete_event(p_repeat_on IN CHAR, p_event_details IN VARCHAR2)
IS
BEGIN
	/*=========Delete Event on basis of Event Details..
	-----Need of using EVENT_DETAILS column to delete is:-----
		There will be issue while deleting Events created on Daily,Weekly,Monthly and Yearly basis. 
		We cant delete using EVENT_ID. So, here Event Details will be comman for all the above Event Types
	============*/
	
	DELETE FROM INSTITUTE_CALENDAR 
    WHERE EVENT_DETAILS = p_event_details;

    /*IF (p_repeat_on = 's')THEN
        DELETE FROM INSTITUTE_CALENDAR 
        WHERE EVENT_DETAILS = p_event_details;

    ELSIF (p_repeat_on = 'd')THEN
        DELETE FROM INSTITUTE_CALENDAR
        WHERE EVENT_DETAILS = p_event_details;

    ELSIF(p_repeat_on = 'w')THEN
        DELETE FROM INSTITUTE_CALENDAR
        WHERE EVENT_DETAILS = p_event_details;
   
    ELSIF(p_repeat_on = 'm')THEN
        DELETE FROM INSTITUTE_CALENDAR
        WHERE EVENT_DETAILS = p_event_details;

    ELSIF(p_repeat_on = 'y')THEN
        DELETE FROM INSTITUTE_CALENDAR
        WHERE EVENT_DETAILS = p_event_details;
    END IF;*/

    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception in Event Deletion');
END delete_event;

-------------------------------------Leave Memo------------------------------------
procedure leave_memo(
    p_memo_type IN CHAR, 
    p_memo_sub IN VARCHAR2, 
    p_memo_matter IN VARCHAR2, 
    p_appuser IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER)
IS
    l_user_nm VARCHAR2(20);
    l_user_type NUMBER;
BEGIN
    SELECT LOWER(USERNAME) INTO l_user_nm 
    FROM USERS_MST 
    WHERE USER_TYPE_ID = APP_UTIL.get_usertypeid_fromrole('ADM', p_inst_id)
        AND INSTUTUTE_ID = p_inst_id;

    l_user_type := APP_UTIL.get_usertypeid_fromusername(p_appuser, p_inst_id);

    IF(p_memo_type = 'LM') THEN
        INSERT INTO TMS.EMS_MEMO(MEMO_ID,
                            SENDER,
                            RECEIVER,
                            MEMO_SUBJECT,
                            MEMO_METTER,
                            MEMO_TIME,
                            USER_TYPE_ID,
                            ISREAD,
                            ISSENTDELETED,
                            INSTITUTE_ID,
                            AC_YEAR_ID)
        VALUES(EMS_MEMO_SEQ.NEXTVAL,
                upper(p_appuser),
                l_user_nm,
                p_memo_sub,
                p_memo_matter,
                SYSDATE,
                l_user_type,
                0,
                1,
                p_inst_id,
                p_acyr_id);
    END IF;

    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception in Leave Memo');
END leave_memo;

-------------------------------------Accounts Memo------------------------------------
procedure accounts_memo(
    p_memo_type IN CHAR, 
    p_memo_sub IN VARCHAR2, 
    p_memo_matter IN VARCHAR2, 
    p_appuser IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER)
IS
    l_user_nm VARCHAR2(20);
    l_user_type NUMBER;
BEGIN
    SELECT LOWER(USERNAME) INTO l_user_nm 
    FROM USERS_MST 
    WHERE USER_TYPE_ID = APP_UTIL.get_usertypeid_fromrole('ADM', p_inst_id)
    AND INSTUTUTE_ID = p_inst_id;

    l_user_type := APP_UTIL.get_usertypeid_fromusername(p_appuser, p_inst_id);

    IF(p_memo_type = 'AM') THEN
        INSERT INTO TMS.EMS_MEMO(
            MEMO_ID,
            SENDER,
            RECEIVER,
            MEMO_SUBJECT,
            MEMO_METTER,
            MEMO_TIME,
            USER_TYPE_ID,
            ISREAD,
            ISSENTDELETED,
            INSTITUTE_ID,
            AC_YEAR_ID)
        VALUES(
            EMS_MEMO_SEQ.NEXTVAL,
            upper(p_appuser),
            l_user_nm,
            p_memo_sub,
            p_memo_matter,
            SYSDATE,
            l_user_type,
            0,
            1,
            p_inst_id,
            p_acyr_id);
    END IF;

    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception in Accounts Memo');
END accounts_memo;

-------------------------------------Production Memo------------------------------------
procedure production_memo(
    p_memo_rec IN CHAR, 
    p_memo_sub IN VARCHAR2, 
    p_memo_matter IN VARCHAR2,
    p_user_type IN VARCHAR2,
    p_user_names IN VARCHAR2, 
    p_appuser IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER)
IS
    temp_username varchar2(100);
	temp_entity_type number;
    
    CURSOR c1 IS SELECT USERNAME FROM USERS_MST WHERE INSTUTUTE_ID = p_inst_id;
	CURSOR c2 IS SELECT USERNAME FROM USERS_MST WHERE USER_TYPE_ID = p_user_type AND INSTUTUTE_ID = p_inst_id;
BEGIN
    temp_entity_type := 84;

	IF(p_memo_rec = 'TAU') THEN
		OPEN c1;
            WHILE(true)
            LOOP
		        FETCH c1 INTO temp_username;
                EXIT WHEN c1%NOTFOUND;                		
        		
                INSERT INTO TMS.EMS_MEMO(
                    MEMO_ID,
                    SENDER,
                    RECEIVER,
                    MEMO_SUBJECT,
                    MEMO_METTER,
                    MEMO_TIME,
                    USER_TYPE_ID,
                    ISREAD,
                    ISDELETE,
                    ISSENTDELETED,
                    INSTITUTE_ID,
                    AC_YEAR_ID)
                VALUES(
                    EMS_MEMO_SEQ.NEXTVAL,
                    upper(p_appuser),
                    temp_username,
                    p_memo_sub,
                    p_memo_matter,
                    SYSDATE,
                    temp_entity_type,
                    0,
                    1,
                    1,
                    p_inst_id,
                    p_acyr_id);
            END LOOP;
		CLOSE c1;
	END IF;
    
	IF(p_memo_rec = 'APL') THEN
		OPEN c2;
		    WHILE(true)
		    LOOP
    		    FETCH c2 INTO temp_username;
                EXIT WHEN c2%NOTFOUND;                		
    		    
                INSERT INTO TMS.EMS_MEMO(
                    MEMO_ID,
                    SENDER,
                    RECEIVER,
                    MEMO_SUBJECT,
                    MEMO_METTER,
                    MEMO_TIME,
                    USER_TYPE_ID,
                    ISREAD,
                    ISSENTDELETED,
                    INSTITUTE_ID)
                VALUES(
                    EMS_MEMO_SEQ.NEXTVAL,
                    upper(p_appuser),
                    temp_username,
                    p_memo_sub,
                    p_memo_matter,
                    SYSDATE,
                    temp_entity_type,
                    0,
                    1,
                    p_inst_id);
            END LOOP;
    	CLOSE c2;		
    END IF;  

	IF(p_memo_rec = 'IPL') THEN  
        INSERT INTO TMS.EMS_MEMO(
            MEMO_ID,
            SENDER,
            RECEIVER,
            MEMO_SUBJECT,
            MEMO_METTER,
            MEMO_TIME,
            USER_TYPE_ID,
            ISREAD,
            ISSENTDELETED,
            INSTITUTE_ID)
        VALUES(
            EMS_MEMO_SEQ.NEXTVAL,
            upper(p_appuser),
            p_user_names,
            p_memo_sub,
            p_memo_matter,
            SYSDATE,
            p_user_type,
            0,
            1,
            p_inst_id);
    END IF;

    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception in Production Memo');
END production_memo;

-------------------------------------Production Memo for Employee------------------------------------
procedure production_memo_emp(
    p_memo_rec IN CHAR, 
    p_memo_sub IN VARCHAR2, 
    p_memo_matter IN VARCHAR2, 
    p_user_type IN VARCHAR2,
    p_user_names IN VARCHAR2,
    p_appuser IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER)
IS
	temp_username varchar2(30);
	temp_entity_type number;

    CURSOR c1 IS SELECT USERNAME FROM USERS_MST WHERE INSTUTUTE_ID = p_inst_id;
	CURSOR c2 IS SELECT USERNAME FROM USERS_MST WHERE USER_TYPE_ID = p_user_type AND INSTUTUTE_ID = p_inst_id;
BEGIN
    temp_entity_type := 84;

	IF(p_memo_rec = 'TAU') THEN
		OPEN c1;
            WHILE(true)
            LOOP
    		    FETCH c1 INTO temp_username;
                EXIT WHEN c1%NOTFOUND;                		
    		    
                INSERT INTO TMS.EMS_MEMO(
                    MEMO_ID,
                    SENDER,
                    RECEIVER,
                    MEMO_SUBJECT,
                    MEMO_METTER,
                    MEMO_TIME,
                    USER_TYPE_ID,
                    ISREAD,
                    ISDELETE,
                    ISSENTDELETED,
                    INSTITUTE_ID,
                    AC_YEAR_ID)
                VALUES(
                    EMS_MEMO_SEQ.NEXTVAL,
                    upper(p_appuser),
                    temp_username,
                    p_memo_sub,
                    p_memo_matter,
                    SYSDATE,
                    temp_entity_type,
                    0,
                    1,
                    1,
                    p_inst_id,
                    p_acyr_id);
            END LOOP;
		CLOSE c1;
	END IF;

	IF(p_memo_rec = 'APL') THEN
		OPEN c2;
    		WHILE(true)
    		LOOP
    		    FETCH c2 INTO temp_username;
                EXIT WHEN c2%NOTFOUND;                		
                
                INSERT INTO TMS.EMS_MEMO(
                    MEMO_ID,
                    SENDER,
                    RECEIVER,
                    MEMO_SUBJECT,
                    MEMO_METTER,
                    MEMO_TIME,
                    USER_TYPE_ID,
                    ISREAD,
                    ISSENTDELETED,
                    INSTITUTE_ID,
                    AC_YEAR_ID)
                VALUES(
                    EMS_MEMO_SEQ.NEXTVAL,
                    upper(p_appuser),
                    temp_username,
                    p_memo_sub,
                    p_memo_matter,
                    SYSDATE,
                    temp_entity_type,
                    0,
                    1,
                    p_inst_id,
                    p_acyr_id);
            END LOOP;
		CLOSE c2;		
    END IF; 

	IF(p_memo_rec = 'IPL') THEN  
        INSERT INTO TMS.EMS_MEMO(MEMO_ID,
            SENDER,
            RECEIVER,
            MEMO_SUBJECT,
            MEMO_METTER,
            MEMO_TIME,
            USER_TYPE_ID,
            ISREAD,
            ISSENTDELETED,
            INSTITUTE_ID,
            AC_YEAR_ID)
        VALUES(EMS_MEMO_SEQ.NEXTVAL,
            upper(p_appuser),
            p_user_names,
            p_memo_sub,
            p_memo_matter,
            SYSDATE,
            p_user_type,
            0,
            1,
            p_inst_id,
            p_acyr_id);
    END IF;
END production_memo_emp;

-------------------------------------Send Internal Mail------------------------------------
procedure send_internal_mail(
    p_mail_rec IN CHAR, 
    p_mail_sub IN VARCHAR2, 
    p_mail_matter IN VARCHAR2, 
    p_med_id IN NUMBER,
    p_std_id IN NUMBER,
    p_sem_id IN NUMBER,
    p_div_id IN NUMBER,
    p_dept_id IN NUMBER,
    p_user_type IN VARCHAR2,
    p_appuser IN VARCHAR2, 
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER)
IS
    temp_username varchar2(100);
    temp_user varchar2(100);
	temp_entity_type number;
    l_stud_utype NUMBER;
    l_par_utype NUMBER;
    l_emp_utype NUMBER;

    cursor c1 is select USERNAME FROM USERS_MST WHERE USER_TYPE_ID IN (SELECT USER_TYPE_ID FROM USERS_TYPE_MST WHERE USER_TYPE_CODE IN ('STUD','PAR') AND INSTITUTE_ID = p_inst_id) AND INSTUTUTE_ID = p_inst_id;
    
    cursor c2 is SELECT (SELECT USERNAME FROM USERS_MST WHERE USER_ID = ST.USER_ID AND INSTUTUTE_ID = p_inst_id) FROM STUDENTS_DET ST
                WHERE INSTITUTE_ID = p_inst_id AND
                AC_YEAR_ID = p_acyr_id AND
                CUR_MED = p_med_id AND 
                CUR_STD = p_std_id AND  
                (CUR_SEM = p_sem_id OR CUR_SEM IS NULL) AND
                DIVISION_ID = p_div_id;

    cursor c3 is SELECT (SELECT USERNAME FROM USERS_MST WHERE USER_ID = PT.USER_ID AND INSTUTUTE_ID = p_inst_id) FROM PARENTS_DET PT, STUD_PAR_MAP SP ,STUDENTS_DET ST
                WHERE SP.PARENTS_ID_FK = PT.PARENTS_ID AND
                       SP.STUDENT_ID_FK = ST.STUDENT_ID AND 
                       ST.INSTITUTE_ID = p_inst_id AND
                       ST.AC_YEAR_ID = p_acyr_id AND
                       ST.CUR_MED = p_med_id AND 
                       ST.CUR_STD = p_std_id AND  
                       (ST.CUR_SEM = p_sem_id OR ST.CUR_SEM IS NULL) AND
                       ST.DIVISION_ID = p_div_id;       

    cursor c4 is SELECT (SELECT USERNAME FROM USERS_MST WHERE USER_ID = EMP.USER_ID AND INSTUTUTE_ID = p_inst_id) 
                FROM EMPLOYEE_DET EMP
                WHERE INSTITUTE_ID = p_inst_id 
                    AND (DEPARTMENT IS NULL OR DEPARTMENT = p_dept_id);  
BEGIN
    l_stud_utype := APP_UTIL.get_usertypeid_fromrole('STUD', p_inst_id);
    
    l_par_utype := APP_UTIL.get_usertypeid_fromrole('PAR', p_inst_id);
    
    l_emp_utype := APP_UTIL.get_usertypeid_fromrole('EMP', p_inst_id);
    
    temp_entity_type := APP_UTIL.get_usertypeid_fromusername(p_appuser, p_inst_id);

	IF(p_mail_rec = 'TAU') THEN
		OPEN c1;
            WHILE(true)
            LOOP
		        FETCH c1 into temp_username;
                EXIT WHEN c1%NOTFOUND;                		
		        
                INSERT INTO TMS.EMS_EMAIL(
                    EMAIL_PK,
                    INSTITUTE_ID,
                    MED_ID,
                    STD_ID,
                    DIVISION_ID,
                    SENDER,
                    RECEIVER,
                    SUBJECT,
                    MATTER,
                    EMAIL_DATE,
                    USER_TYPE_ID,
                    AC_YEAR_ID)
                VALUES(
                    EMS_EMAIL_SEQ.NEXTVAL,
                    p_inst_id,
                    null,
                    null,
                    null,
                    upper(p_appuser),
                    temp_username,
                    p_mail_sub,
                    p_mail_matter,
                    SYSDATE,
                    temp_entity_type,
                    p_acyr_id);
            END LOOP;
		CLOSE c1;
	END IF;
    
    APEX_DEBUG.INFO('APL' || p_mail_rec);

	IF(p_mail_rec = 'APL' AND p_user_type = 'STUD') THEN
		OPEN c2;
    		WHILE(true)
    		LOOP
        		FETCH c2 into temp_username;
                EXIT WHEN c2%NOTFOUND;                		
    		    
                INSERT INTO TMS.EMS_EMAIL(
                    EMAIL_PK,
                    SENDER,
                    RECEIVER,
                    SUBJECT,
                    MATTER,
                    EMAIL_DATE,
                    USER_TYPE_ID,
                    INSTITUTE_ID,
                    MED_ID,
                    STD_ID,
                    DIVISION_ID,
                    SEM_ID,
                    AC_YEAR_ID)
                VALUES(
                    EMS_EMAIL_SEQ.NEXTVAL,
                    upper(p_appuser),
                    temp_username,
                    p_mail_sub,
                    p_mail_matter,
                    SYSDATE,
                    temp_entity_type,
                    p_inst_id,
                    p_med_id,
                    p_std_id,
                    p_div_id,
                    p_sem_id,
                    p_acyr_id);
            END LOOP;
		CLOSE c2;	

    ELSIF(p_mail_rec = 'APL' AND p_user_type = 'PAR') THEN
		OPEN c3;
    		WHILE(true)
    		LOOP
    		    FETCH c3 into temp_user;
                EXIT WHEN c3%NOTFOUND; 
                               		
				INSERT INTO TMS.EMS_EMAIL(
                    EMAIL_PK,
                    SENDER,
                    RECEIVER,
                    SUBJECT,
                    MATTER,
                    EMAIL_DATE,
                    USER_TYPE_ID,
                    INSTITUTE_ID,
                    MED_ID,
                    STD_ID,
                    DIVISION_ID,
                    SEM_ID,
                    AC_YEAR_ID)
                VALUES(
                    EMS_EMAIL_SEQ.NEXTVAL,
                    upper(p_appuser),
                    temp_username,
                    p_mail_sub,
                    p_mail_matter,
                    SYSDATE,
                    temp_entity_type,
                    p_inst_id,
                    p_med_id,
                    p_std_id,
                    p_div_id,
                    p_sem_id,
                    p_acyr_id);
            END LOOP;
		CLOSE c3;		
        
    ELSIF(p_mail_rec = 'APL' AND p_user_type = 'EMP') THEN
		OPEN c4;
		    WHILE(true)
		    LOOP
    		    FETCH c4 into temp_user;
                EXIT WHEN c4%NOTFOUND;                		
    			
                INSERT INTO TMS.EMS_EMAIL(
                    EMAIL_PK,
                    SENDER,
                    RECEIVER,
                    SUBJECT,
                    MATTER,
                    EMAIL_DATE,
                    USER_TYPE_ID,
                    INSTITUTE_ID,
                    AC_YEAR_ID)
                VALUES(
                    EMS_EMAIL_SEQ.NEXTVAL,
                    upper(p_appuser),
                    temp_user,
                    p_mail_sub,
                    p_mail_matter,
                    SYSDATE,
                    temp_entity_type,
                    p_inst_id,
                    p_acyr_id);
            END LOOP;
		CLOSE c4;		
    END IF;   
END send_internal_mail;

END EMS_EVENT_MSG_MAIL_UTIL;

/
