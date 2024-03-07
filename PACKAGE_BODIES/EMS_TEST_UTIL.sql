--------------------------------------------------------
--  DDL for Package Body EMS_TEST_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."EMS_TEST_UTIL" as

-------------------------------------Insert Uploaded Questions to DB---------------------------------------
procedure upload_questions_to_db(p_inst_id IN NUMBER, p_acyr_id IN NUMBER)
IS
    l_qid_pk NUMBER;
    l_scope logger_logs.scope%type := 'EMS_TEST_UTIL.upload_questions_to_db'; 
    l_params logger.tab_param; 
BEGIN
	--Loop through Collection
    FOR I IN (SELECT SEQ_ID,C001,C002,C003,C004,C005,C006,C007,C008,C009,C010,
                C011,C012,C013,C014,C015,C016,C017,C018,C019,C020,
                C021,C022,C023,C024
            FROM APEX_COLLECTIONS
            WHERE COLLECTION_NAME = 'STORE_QUESTION_BANK')
    LOOP
		--Insert Question
        INSERT INTO TMS.EMS_QUESTION_BANK(QID_PK, QUESTION, CHAPTER_NAME, QUESTION_TYPE,
            SHOW_CORRECT_ANSWER_LAST, CORRECT_ANSWER_NO, MARK_VALUE, QUESTION_HEADER, QUESTION_FOOTER, REMARKS,
            INSTITUTE_ID, STD_ID, SUB_ID, MED_ID, SEM_ID, AC_YEAR_ID) 

        VALUES(EMS_QUESTION_SEQ.NEXTVAL, I.C001, I.C002,DECODE(I.C009,'Objective',1,'Subjective',2),
            DECODE(I.C010,'Yes',1,'No',2), NULL, I.C011, I.C016, I.C017, I.C018,
            p_inst_id, I.C020, I.C022, I.C019, I.C021, p_acyr_id)
        RETURNING QID_PK INTO l_qid_pk;

		--Check whether option is field is null or not...if not then Insert Options..
        IF(I.C003 IS NOT NULL) THEN
            INSERT INTO TMS.EMS_QUESTION_OPTION(OPTION_PK, QID_FK, OPTIONS)
            VALUES(EMS_OPTION_SEQ.NEXTVAL, l_qid_pk, I.C003);
        END IF;	

        IF(I.C004 IS NOT NULL) THEN
            INSERT INTO TMS.EMS_QUESTION_OPTION(OPTION_PK, QID_FK, OPTIONS)
            VALUES(EMS_OPTION_SEQ.NEXTVAL, l_qid_pk, I.C004);
        END IF;

        IF(I.C005 IS NOT NULL) THEN
            INSERT INTO TMS.EMS_QUESTION_OPTION(OPTION_PK, QID_FK, OPTIONS)
            VALUES(EMS_OPTION_SEQ.NEXTVAL, l_qid_pk, I.C005);	
        END IF;

        IF(I.C006 IS NOT NULL) THEN
            INSERT INTO TMS.EMS_QUESTION_OPTION(OPTION_PK, QID_FK, OPTIONS)
            VALUES(EMS_OPTION_SEQ.NEXTVAL, l_qid_pk, I.C006);	
        END IF;

        IF(I.C007 IS NOT NULL) THEN
            INSERT INTO TMS.EMS_QUESTION_OPTION(OPTION_PK, QID_FK, OPTIONS)
            VALUES(EMS_OPTION_SEQ.NEXTVAL, l_qid_pk, I.C007);	
        END IF;

		--Collection column C008 represents Correct Answer option for the question.
		--So call the 'EMS_TEST_UTIL.insert_correct_ans' procedure to update correct ans..

        IF (I.C008 IS NOT NULL) THEN
            --INSERT INTO TMS.EMS_QUESTION_OPTION(OPTION_PK, QID_FK, OPTIONS)
            --VALUES(EMS_OPTION_SEQ.NEXTVAL, l_qid_pk, I.C008);

            EMS_TEST_UTIL.insert_correct_ans (I.C008, l_qid_pk, p_inst_id);
        END IF;
    END LOOP;

    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(p_collection_name => 'STORE_QUESTION_BANK');
    
    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception in collection STORE_QUESTION_BANK', l_scope, null, l_params); 
END upload_questions_to_db;

-------------------------------------Insert Correct answer for Question--------------------------------
procedure insert_correct_ans(p_correct_ans IN VARCHAR2, p_qid_pk in NUMBER, p_inst_id IN NUMBER)
IS 
    l_option TMS.EMS_QUESTION_OPTION.OPTIONS%TYPE;
    l_correct_ans TMS.EMS_QUESTION_BANK.CORRECT_ANSWER_NO%TYPE;
    l_scope logger_logs.scope%type := 'EMS_TEST_UTIL.insert_correct_ans'; 
    l_params logger.tab_param; 
BEGIN
   /* FOR I IN (SELECT SEQ_ID,C001,C008 FROM APEX_COLLECTIONS
            WHERE COLLECTION_NAME = 'STORE_QUESTION_BANK')
    LOOP*/

	--Get Option Id and option from Inserted options by comparing correct ans text..
    SELECT OPTION_PK, OPTIONS INTO l_correct_ans, l_option FROM TMS.EMS_QUESTION_OPTION
    WHERE OPTIONS = p_correct_ans 
        AND QID_FK = p_qid_pk; --(SELECT QID_PK FROM TMS.EMS_QUESTION_BANK WHERE QUESTION = p_question AND INSTITUTE_ID = p_inst_id);
    
	--Update the CORRECT_ANSWER_NO field of Question Bank with above fetched Option ID..
    UPDATE TMS.EMS_QUESTION_BANK
    SET CORRECT_ANSWER_NO = l_correct_ans
    WHERE QID_PK = p_qid_pk --(SELECT QID_PK FROM TMS.EMS_QUESTION_BANK WHERE QUESTION = p_question AND INSTITUTE_ID = p_inst_id)
        AND INSTITUTE_ID = p_inst_id;
    
    --END LOOP;

    EXCEPTION WHEN OTHERS THEN logger.log_error('Unhandled Exception in collection STORE_QUESTION_BANK', l_scope, null, l_params); 
END insert_correct_ans;

END EMS_TEST_UTIL;

/
