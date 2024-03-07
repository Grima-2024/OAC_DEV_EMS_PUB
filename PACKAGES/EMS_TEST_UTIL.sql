--------------------------------------------------------
--  DDL for Package EMS_TEST_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."EMS_TEST_UTIL" as

---------------------------------------------------------------------------------------------------------------------- 
---------------=====This package contains code for Uploading Questions from xlsx file to table=======-----------------
---------------------------------------------------------------------------------------------------------------------- 

procedure upload_questions_to_db(
    p_inst_id IN NUMBER, 
    p_acyr_id IN NUMBER
);

procedure insert_correct_ans(
    p_correct_ans IN VARCHAR2, 
    p_qid_pk in NUMBER,
    p_inst_id IN NUMBER
);

END EMS_TEST_UTIL;

/
