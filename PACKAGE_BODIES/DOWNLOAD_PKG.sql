--------------------------------------------------------
--  DDL for Package Body DOWNLOAD_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."DOWNLOAD_PKG" as
    
procedure fees_receipt (p_stud_id in number, p_fees_id in number, p_inst in number)
AS 
    INM VARCHAR2(50);
    IADD VARCHAR2(500);
    ICITY VARCHAR2(50);
    IMAIL VARCHAR2(100);
    IPH VARCHAR2(100);
    ACA VARCHAR2(50);
    l_pdf_doc blob;
    v_file_name varchar2(30) := 'Fees_Receipt.pdf';
    SNM VARCHAR2(50);
    STD VARCHAR2(50);
    SEM VARCHAR2(50);
    RNO VARCHAR2(50);
    REC VARCHAR2(10);
    FDATE DATE;
    AMT NUMBER;
    PAYTP VARCHAR2(10);
    TAMT NUMBER;
    BKNM VARCHAR2(100);
    CHNO NUMBER;
    CHDT DATE;
    FTYPE VARCHAR2(50);
    DAMT NUMBER;
    DIS NUMBER;
    DISAMT NUMBER;
    CHARGE NUMBER;
    HFEES VARCHAR2(5);
    v_logo blob;
    t_heading varchar(1000);
    t_rc sys_refcursor;
    t_query varchar2(3000);
BEGIN
    SELECT INSTITUTE_NAME,INST_ADDRESS,INST_CITY,EMAIL,TEL_PHONE_NO
    INTO INM,IADD,ICITY,IMAIL,IPH
    FROM INSTITUTE_MST WHERE INSTITUTE_ID = p_inst;

    SELECT YEAR_NAME INTO ACA FROM ACADEMIC_YEAR_MST WHERE AC_YEAR_ID = v('APP_ACADEMIC');

    select DISTINCT (SELECT  FIRSTNAME || ' ' ||SUBSTR(MIDDLENAME,1,1)|| ' ' ||LASTNAME FROM STUDENTS_DET WHERE STUDENT_ID = SF.STUDENT_ID),
        (SELECT STD_NAME FROM STANDARD_MST WHERE STD_ID = SF.STD_ID),
        NVL((SELECT SEM_NAME FROM SEMESTER_MST WHERE SEM_ID = SF.SEM_ID),'-'),
        (SELECT ROLL_NO FROM STUDENTS_DET WHERE STUDENT_ID = SF.STUDENT_ID),
        RECEIPT_NO,
        FEES_DATE,
        PAYMENT_TYPE,
        BANK_NAME,
        CHEQUE_NO,
        CHEQUE_DT,
        DUE_AMOUNT,
        ALLOW_HALF_FEES,
        TOTAL_AMT,
        DISCOUT_AMT,
        DISCOUNT_PER,
        CHARGE_AFTER_DUE_DT
    INTO SNM, STD, SEM, RNO, REC, FDATE, PAYTP, BKNM, CHNO, CHDT, DAMT, HFEES, TAMT, DIS, DISAMT, CHARGE
    from STUDENT_FEES_DET SF
    where STUDENT_ID = p_stud_id
        and FEES_ID = p_fees_id;

    /*select file_content INTO v_logo from apex_application_static_files 
    WHERE  file_name = 'Background2/BG2.jpg'
    and application_id = 105; */

    as_pdf3.init;
    --as_pdf3.load_ttf_font( 'MY_FONTS', 'COLONNA.TTF', 'CID' );
    as_pdf3.set_page_orientation('PORTRAIT');
    as_pdf3.set_font( 'times', 'b' ,16);
    as_pdf3.set_margins(p_left => 2, p_right => 2, p_unit => 'cm');

    if v_logo is not null then 
            --as_pdf3.put_image(v_logo, 20, 750,100,100); 
        as_pdf3.put_image(v_logo, 750,  as_pdf3.get( as_pdf3.C_GET_PAGE_HEIGHT ) - 90,175,70); 
        null;
    end if;

    as_pdf3.set_color(255,0,0);
    as_pdf3.WRITE(UPPER(INM), -1, 740, p_alignment => 'center');
    as_pdf3.set_font( 'helvetica' ,12); 
    as_pdf3.set_color('#00000');
    as_pdf3.WRITE('Address: ' || IADD || ' , ' || ICITY, -1, 720 , p_alignment => 'center'); 
    as_pdf3.WRITE('Email: ' || IMAIL, -1, -1, p_alignment => 'center'); 
    as_pdf3.WRITE('Telephone No: ' || IPH,-1, -1, p_alignment => 'center');
    as_pdf3.set_font( 'helvetica', 'b',13); 
    as_pdf3.horizontal_line( 60, 690, 460, 1);
    as_pdf3.WRITE('FEE RECEIPT', -2 , 675, p_alignment => 'center' );
    as_pdf3.horizontal_line( 60, 670, 460, 1);

    as_pdf3.set_font( 'helvetica',12);
    as_pdf3.WRITE('Academic Year: ' || ACA ,-1, 655, p_alignment => 'center'); 
    as_pdf3.WRITE('Date: ' || TO_CHAR(FDATE,'DD-Mon-YYYY'), 60, -1, p_alignment => 'left'); 
    as_pdf3.WRITE('Receipt No: ' || REC, 400, p_alignment => 'left'); 
    as_pdf3.horizontal_line( 60, 637, 460, 1);

    as_pdf3.WRITE('Student Name: ' || SNM ,60 , 620, p_alignment => 'left'); 
    as_pdf3.WRITE('Roll No: ' || RNO, 400, p_alignment => 'left'); 
    as_pdf3.WRITE('Standard: ' || STD, 60 , 600, p_alignment => 'left'); 
    as_pdf3.WRITE('Semester: ' || SEM, 400, p_alignment => 'left'); 
    
    as_pdf3.set_font( 'helvetica', 'b',12);
    as_pdf3.horizontal_line( 60, 590, 460, 1);
    /*as_pdf3.WRITE('Fees Type' , 100, 575, p_alignment => 'left');
    as_pdf3.WRITE('Amount' ,400, p_alignment => 'left'); 
    as_pdf3.horizontal_line( 60, 570, 460, 1);*/
    
    
    /*FOR I IN (SELECT AMOUNT, FEES_TYPE_ID FROM STUDENT_FEES_DET WHERE STUDENT_ID = p_stud_id)
    LOOP
        SELECT FEES_TYPE INTO FTYPE FROM FEES_TYPE_MST WHERE FEES_TYPE_ID = I.FEES_TYPE_ID;
        as_pdf3.WRITE( FTYPE , 100, 555, p_alignment => 'left');
        as_pdf3.WRITE( I.AMOUNT , 400, p_alignment => 'left');
    END LOOP;*/

    as_pdf3.set_font( 'helvetica','b',12);
    as_pdf3.WRITE(' ' ,60, 587, p_alignment => 'left'); 
    t_heading := 'SELECT ''Fees Type'',''Amount'' FROM DUAL';
    as_pdf3.query2table(t_heading);

    as_pdf3.set_font( 'helvetica',12);
    t_query := 'SELECT FT.FEES_TYPE,
                SF.AMOUNT  
                FROM STUDENT_FEES_DET SF, FEES_TYPE_MST FT
                WHERE STUDENT_ID = '''|| p_stud_id ||''' 
                    AND FEES_ID = '''|| p_fees_id ||'''
                    AND SF.FEES_TYPE_ID = FT.FEES_TYPE_ID';
    open t_rc for t_query;
    as_pdf3.WRITE(' ' , 60, 565, p_alignment => 'left');
    as_pdf3.refcursor2table( t_rc );

    t_query := 'SELECT ''Discount Amount'',
                    DISCOUT_AMT
                FROM STUDENT_FEES_DET SF, FEES_TYPE_MST FT
                WHERE STUDENT_ID = '''|| p_stud_id ||''' 
                    AND FEES_ID = '''|| p_fees_id ||'''
                    AND SF.FEES_TYPE_ID = FT.FEES_TYPE_ID';
    open t_rc for t_query;
    as_pdf3.WRITE(' ' , 60, 540, p_alignment => 'left');
    as_pdf3.refcursor2table( t_rc );

    t_query := 'SELECT ''Charge After Due Date'',
                    CHARGE_AFTER_DUE_DT
                FROM STUDENT_FEES_DET SF, FEES_TYPE_MST FT
                WHERE STUDENT_ID = '''|| p_stud_id ||''' 
                    AND FEES_ID = '''|| p_fees_id ||'''
                    AND SF.FEES_TYPE_ID = FT.FEES_TYPE_ID';
    open t_rc for t_query;
    as_pdf3.WRITE(' ' , 60, 520, p_alignment => 'left');
    as_pdf3.refcursor2table( t_rc );

    /*as_pdf3.WRITE('Discount Amount' , 60, -1, p_alignment => 'left');
    as_pdf3.WRITE( DISAMT , 400, p_alignment => 'left');
    as_pdf3.WRITE('Charge Amount' , 60, -1, p_alignment => 'left');
    as_pdf3.WRITE( CHARGE , 400, p_alignment => 'left');*/

    --as_pdf3.horizontal_line( 60, 525, 460, 1);
    --as_pdf3.WRITE('Total Fee Amount' , 100, 400, p_alignment => 'left');
    --as_pdf3.WRITE( TAMT , 400, p_alignment => 'left');
    --as_pdf3.WRITE('Total Paid Amount' , 100, -1, p_alignment => 'left');
    --as_pdf3.WRITE('Remaining Amount' , 100, -1, p_alignment => 'left');

    /*as_pdf3.horizontal_line( 60, 500, 460, 1);
    as_pdf3.vertical_line( 60 ,500, 90, 1 );
    as_pdf3.vertical_line( 520 ,500, 90, 1 );
    as_pdf3.vertical_line( 280 ,500, 90, 1 );*/

    as_pdf3.horizontal_line( 60, 485, 460, 1);
    as_pdf3.set_font( 'helvetica', 'b',12); 
    as_pdf3.WRITE('Payment Mode' , 62, 470, p_alignment => 'left');
    as_pdf3.WRITE('Bank' ,155, p_alignment => 'left'); 
    as_pdf3.WRITE('Cheque No' ,290, p_alignment => 'left'); 
    as_pdf3.WRITE('Cheque Date' ,380, p_alignment => 'left'); 
    as_pdf3.WRITE('Amount' ,470, p_alignment => 'left'); 
    as_pdf3.horizontal_line( 60, 465, 460, 1);

    IF(HFEES = 'No')THEN
        as_pdf3.set_font( 'helvetica', 12); 
        as_pdf3.WRITE( PAYTP , 62, 450, p_alignment => 'left');
        as_pdf3.WRITE( BKNM ,155, p_alignment => 'left'); 
        as_pdf3.WRITE( CHNO ,290, p_alignment => 'left'); 
        as_pdf3.WRITE( CHDT ,380, p_alignment => 'left'); 
        as_pdf3.WRITE( TAMT ,470, p_alignment => 'left'); 

        as_pdf3.WRITE('Net Amount Paid' , 62, 430, p_alignment => 'left');
        as_pdf3.WRITE( TAMT ,470, p_alignment => 'left'); 
        as_pdf3.horizontal_line( 60, 425, 460, 1);

    ELSE
        as_pdf3.set_font( 'helvetica', 12); 
        as_pdf3.WRITE( PAYTP , 62, 450, p_alignment => 'left');
        as_pdf3.WRITE( BKNM ,155, p_alignment => 'left'); 
        as_pdf3.WRITE( CHNO ,290, p_alignment => 'left'); 
        as_pdf3.WRITE( CHDT ,380, p_alignment => 'left'); 
        as_pdf3.WRITE( TAMT ,470, p_alignment => 'left'); 

        as_pdf3.WRITE('Net Amount Paid' , 62, 430, p_alignment => 'left');
        as_pdf3.WRITE( TAMT ,470, p_alignment => 'left'); 
        as_pdf3.horizontal_line( 60, 425, 460, 1);

    END IF;
    
    as_pdf3.vertical_line( 60 , 425, 60, 1 );
    as_pdf3.vertical_line( 150 ,445, 40, 1 );
    as_pdf3.vertical_line( 280 ,445, 40, 1 );
    as_pdf3.vertical_line( 370 ,445, 40, 1 );
    as_pdf3.vertical_line( 460 ,425, 60, 1 );
    as_pdf3.vertical_line( 520 ,425, 60, 1 );
    
    as_pdf3.horizontal_line( 60, 445, 460, 1);

    IF(DAMT != 0) THEN
        as_pdf3.WRITE('Remaining Fees to be Paid : ' , 62, 410, p_alignment => 'left');
        as_pdf3.WRITE( 'Rs.' || DAMT ,465, p_alignment => 'left'); 
        as_pdf3.horizontal_line( 60, 400, 460, 1);
    END IF;
    
    l_pdf_doc := as_pdf3.get_pdf;
    
    owa_util.mime_header( 'application/pdf', false );
    sys.htp.print( 'Content-Length: ' || dbms_lob.getlength( l_pdf_doc ) );
    sys.htp.print( 'Content-Disposition:  attachment; filename="' || v_file_name || '"' );
    sys.htp.print( 'Content-Description: Generated by as_pdf3' );
    owa_util.http_header_close;
    
    sys.wpg_docload.download_file( l_pdf_doc );
    apex_application.stop_apex_engine;

end fees_receipt;

---------------------------------------------------------
--FEES INVOICE--
---------------------------------------------------------

procedure fees_invoice (p_stud_id in number, p_inst in number)
AS

    INM VARCHAR2(50);
    IADD VARCHAR2(500);
    ICITY VARCHAR2(50);
    IMAIL VARCHAR2(100);
    IPH VARCHAR2(100);
    ACA VARCHAR2(50);
    l_pdf_doc blob;
    v_file_name varchar2(30) := 'Fees_Invoice';
    SNM VARCHAR2(50);
    STD VARCHAR2(50);
    SEM VARCHAR2(50);
    RNO VARCHAR2(50);
    REC VARCHAR2(10);
    FDATE DATE;
    AMT NUMBER;
    PAYTP VARCHAR2(10);
    TAMT NUMBER;
    BKNM VARCHAR2(100);
    CHNO NUMBER;
    CHDT DATE;
    FTYPE VARCHAR2(50);
    v_logo blob;
    t_heading varchar(1000);
    t_rc sys_refcursor;
    t_query varchar2(3000);
    TOTAL_AMT number;
BEGIN
    SELECT INSTITUTE_NAME,INST_ADDRESS,INST_CITY,EMAIL,TEL_PHONE_NO
    INTO INM,IADD,ICITY,IMAIL,IPH
    FROM INSTITUTE_MST WHERE INSTITUTE_ID = p_inst;

    SELECT YEAR_NAME INTO ACA FROM ACADEMIC_YEAR_MST WHERE AC_YEAR_ID = v('APP_ACADEMIC');

    select file_content INTO v_logo from apex_application_static_files 
    WHERE  file_name = 'Background2/BG2.jpg'
    and application_id = 105; 

    SELECT FIRSTNAME || ' ' ||MIDDLENAME|| ' ' ||LASTNAME, 
        ROLL_NO, 
        (SELECT STD_NAME FROM STANDARD_MST WHERE STD_ID = CUR_STD) , 
        NVL((SELECT SEM_NAME FROM SEMESTER_MST WHERE SEM_ID = CUR_SEM),'-')
    INTO SNM, RNO, STD, SEM
    FROM STUDENTS_DET
    WHERE STUDENT_ID = p_stud_id;


    as_pdf3.init;
    --as_pdf3.load_ttf_font( 'MY_FONTS', 'COLONNA.TTF', 'CID' );
    as_pdf3.set_page_orientation('PORTRAIT');
    as_pdf3.set_font( 'times', 'b' ,16);

    if v_logo is not null then 
            --as_pdf3.put_image(v_logo, 20, 750,100,100); 
        as_pdf3.put_image(v_logo, 750,  as_pdf3.get( as_pdf3.C_GET_PAGE_HEIGHT ) - 90,175,70); 
        null;
    end if;

    as_pdf3.set_color(255,0,0);
    as_pdf3.WRITE(UPPER(INM), -1, 740, p_alignment => 'center');
    as_pdf3.set_font( 'helvetica' ,12); 
    as_pdf3.set_color('#00000');
    as_pdf3.WRITE('Address: ' || IADD || ' , ' || ICITY, -1, 720 , p_alignment => 'center'); 
    as_pdf3.WRITE('Email: ' || IMAIL, -1, -1, p_alignment => 'center'); 
    as_pdf3.WRITE('Telephone No: ' || IPH,-1, -1, p_alignment => 'center');
    as_pdf3.set_font( 'helvetica', 'b',13); 
    as_pdf3.horizontal_line( 60, 690, 460, 1);
    as_pdf3.WRITE('PENDING FEES INVOICE', -2 , 675, p_alignment => 'center' );
    as_pdf3.horizontal_line( 60, 670, 460, 1);

    as_pdf3.set_font( 'helvetica',12); 
    as_pdf3.WRITE('Academic Year: ' || ACA ,-1, 655, p_alignment => 'center'); 
    as_pdf3.WRITE('Date: ' || SYSDATE, 60, -1, p_alignment => 'left'); 
    as_pdf3.WRITE('Invoice No: ' || REC, 400, p_alignment => 'left'); 
    as_pdf3.horizontal_line( 60, 637, 460, 1);

    as_pdf3.WRITE('Student Name: ' || SNM ,60 , 620, p_alignment => 'left'); 
    as_pdf3.WRITE('Roll No: ' || RNO, 400, p_alignment => 'left'); 
    as_pdf3.WRITE('Standard: ' || STD, 60 , 600, p_alignment => 'left'); 
    as_pdf3.WRITE('Semester: ' || SEM, 400, p_alignment => 'left'); 
    as_pdf3.horizontal_line( 60, 590, 460, 1);

    --as_pdf3.set_font( 'helvetica', 'b', 11); 
    --as_pdf3.WRITE('PENDING FEES INVOICE' , 32, 570, p_alignment => 'center');

    as_pdf3.WRITE(' ' , 32, 585, p_alignment => 'center');
    
    as_pdf3.set_font( 'helvetica', 'b', 12);
    t_heading := 'SELECT ''PENDING FEES'',''AMOUNT'' from dual ';
    as_pdf3.query2table( t_heading );

    as_pdf3.set_font( 'helvetica',12);
    t_query := 'select
                (SELECT FEES_TYPE FROM FEES_TYPE_MST WHERE FEES_TYPE_ID = FEES_STRUCTURE_YEARLY.FEES_TYPE_ID) AS "PENDING FEES",
                AMOUNT
        from FEES_STRUCTURE_YEARLY
        WHERE STD_ID = (SELECT CUR_STD FROM STUDENTS_DET WHERE STUDENT_ID = '''|| p_stud_id ||''') AND
            MED_ID = (SELECT CUR_MED FROM STUDENTS_DET WHERE STUDENT_ID = '''|| p_stud_id ||''') AND
            FEES_TYPE_ID NOT IN (SELECT FEES_TYPE_ID FROM STUDENT_FEES_DET) AND
            INSTITUTE_ID = '''|| p_inst ||''' AND
            AC_YEAR_ID = V(''APP_ACADEMIC'')';
----SEM_ID = (SELECT CUR_SEM FROM STUDENTS_DET WHERE STUDENT_ID = '''|| p_stud_id ||''') AND 
        open t_rc for t_query;
        as_pdf3.WRITE(' ' , 32, 567, p_alignment => 'left');
        as_pdf3.refcursor2table( t_rc );
        
        select SUM(AMOUNT) INTO TOTAL_AMT
        from FEES_STRUCTURE_YEARLY
        WHERE STD_ID = (SELECT CUR_STD FROM STUDENTS_DET WHERE STUDENT_ID = p_stud_id) AND
            MED_ID = (SELECT CUR_MED FROM STUDENTS_DET WHERE STUDENT_ID = p_stud_id) AND
            FEES_TYPE_ID NOT IN (SELECT FEES_TYPE_ID FROM STUDENT_FEES_DET) AND
            INSTITUTE_ID = p_inst AND
            AC_YEAR_ID = V('APP_ACADEMIC');
        
        as_pdf3.WRITE( 'TOTAL PENDING AMOUNT: ' || TOTAL_AMT, -1 , -2, p_alignment => 'right');

    l_pdf_doc := as_pdf3.get_pdf;
    
    owa_util.mime_header( 'application/pdf', false );
    sys.htp.print( 'Content-Length: ' || dbms_lob.getlength( l_pdf_doc ) );
    sys.htp.print( 'Content-Disposition:  attachment; filename="' || v_file_name || '"' );
    sys.htp.print( 'Content-Description: Generated by as_pdf3' );
    owa_util.http_header_close;
    
    sys.wpg_docload.download_file( l_pdf_doc );
    apex_application.stop_apex_engine;
END;

---------------------------------------------------------
--PRINT RESULT--
---------------------------------------------------------

procedure result_print (p_test_id in number, p_std_id in number, p_inst in number)
IS
    INM VARCHAR2(50);
    IADD VARCHAR2(500);
    ICITY VARCHAR2(50);
    IMAIL VARCHAR2(100);
    IPH VARCHAR2(100);
    ACA VARCHAR2(50);
    l_pdf_doc blob;
    v_file_name varchar2(30) := 'Print_Result';
    TESTPK NUMBER;
    TESTNM VARCHAR2(50);
    TESTDT DATE;
    TESTTYP VARCHAR2(20);
    TCORR NUMBER;
    TINCORR NUMBER;
    TSCORE NUMBER;
    TSTD VARCHAR2(20);
    TSUB VARCHAR(20);
    TSTUDNM VARCHAR2(30);
    TRES VARCHAR2(20);
    t_rc sys_refcursor;
    t_query varchar2(3000);
    t_heading varchar2(3000);
BEGIN
    SELECT INSTITUTE_NAME,INST_ADDRESS,INST_CITY,EMAIL,TEL_PHONE_NO
    INTO INM,IADD,ICITY,IMAIL,IPH
    FROM INSTITUTE_MST WHERE INSTITUTE_ID = p_inst;

    SELECT YEAR_NAME INTO ACA FROM ACADEMIC_YEAR_MST WHERE AC_YEAR_ID = v('APP_ACADEMIC');
    
    as_pdf3.init;
    as_pdf3.set_page_orientation('PORTRAIT');
    as_pdf3.set_font( 'times', 'b' ,16);
    as_pdf3.set_color(255,0,0);
    as_pdf3.WRITE(UPPER(INM), -1, -1, p_alignment => 'center');
    as_pdf3.set_font( 'helvetica' ,12); 
    as_pdf3.set_color('#00000');
    as_pdf3.WRITE('Address: ' || IADD || ' , ' || ICITY, -1, 705 , p_alignment => 'center'); 
    as_pdf3.WRITE('Email: ' || IMAIL, -1, -1, p_alignment => 'center'); 
    as_pdf3.WRITE('Telephone No: ' || IPH,-1, -1, p_alignment => 'center'); 
    as_pdf3.horizontal_line( 60, 670, 460, 1);

    as_pdf3.WRITE('Academic Year: ' || ACA ,60, 650, p_alignment => 'left'); 
    as_pdf3.WRITE('Date: ' || SYSDATE, 400, p_alignment => 'left'); 
    as_pdf3.horizontal_line( 60, 637, 460, 1);

    FOR I IN(
        SELECT T.test_pk,
            T.test_name, 
            U1.test_date,
            (SELECT ROLL_NO FROM STUDENTS_DET WHERE STUDENT_ID = U1.STUDENT_ID) AS ROLL_NO,
            (SELECT INITCAP(FIRSTNAME) || ' ' || SUBSTR(MIDDLENAME,1,1) || ' ' ||INITCAP(LASTNAME) FROM STUDENTS_DET WHERE STUDENT_ID = U1.STUDENT_ID) AS STUDENT_NAME,
            DECODE(T.TEST_TYPE,1,'Objective', 2, 'Subjective') AS TESTTYP,
            (SELECT STD_NAME FROM STANDARD_MST WHERE STD_ID = U1.STD_ID) AS STDNM,
            (SELECT SUBJECT_NAME FROM SUBJECT_MST WHERE SUB_ID = U1.SUB_ID) AS SUBNM
        FROM TMS.EMS_TEST T, TMS.EMS_test_info U1,USERS_MST L
        WHERE  T.test_pk = U1.test_fk AND
            L.user_id = u1.user_id and 
            U1.session_id <> 0 and
            T.SUB_ID = U1.SUB_ID AND
            T.INSTITUTE_ID = p_inst  AND
            T.AC_YEAR_ID = V('APP_ACADEMIC') AND
            U1.STD_ID = p_std_id AND
            U1.TEST_FK = p_test_id
        GROUP BY  T.test_pk, u1.result,U1.STD_ID,U1.SUB_ID,U1.STUDENT_ID,
            t.test_name, u1.test_date,t.TEST_TYPE
        ORDER BY T.TEST_PK)
    LOOP
        as_pdf3.WRITE('Test Name: ' || I.TEST_NAME ,60 , 620, p_alignment => 'left'); 
        as_pdf3.WRITE('Test Type: ' || I.TESTTYP, 400, p_alignment => 'left'); 
        as_pdf3.WRITE('Subject: ' || I.SUBNM, 60 , 600, p_alignment => 'left'); 
        as_pdf3.WRITE('Standard: ' || I.STDNM, 400, p_alignment => 'left'); 
        as_pdf3.WRITE('Subject: ' || I.STUDENT_NAME, 60 , 580, p_alignment => 'left'); 
        as_pdf3.WRITE('Roll No: ' || I.ROLL_NO, 400, p_alignment => 'left'); 
        as_pdf3.horizontal_line( 60, 570, 460, 1);
        
    END LOOP;

    as_pdf3.WRITE(' ' , 32, 570, p_alignment => 'left');
    as_pdf3.set_font( 'helvetica', 'b', 11); 
    t_heading := 'SELECT ''Appeared On'',''Total Marks'',''Obtained'',''Result'' from dual ';
    as_pdf3.query2table( t_heading );

    as_pdf3.set_font( 'helvetica',12); 
    t_query := 'SELECT
            TO_CHAR(TO_DATE(U1.TEST_DATE,''MM/DD/YYYY''),''DD-MON-YYYY'') AS TEST_DT, 
            (SELECT SUM((SELECT MARK_VALUE FROM TMS.EMS_QUESTION_BANK WHERE QID_PK = QID_FK)) FROM TMS.EMS_TEST_QUES WHERE TEST_FK = '''|| p_test_id ||''') AS TOTAL_MARKS,
            SUM(U1.SCORE) AS SCORE,
            DECODE(U1.RESULT,1,''PASS'',2,''FAIL'') AS RESULT
        FROM TMS.EMS_TEST T, TMS.EMS_test_info U1,USERS_MST L
        WHERE  T.test_pk = U1.test_fk AND
            L.user_id = u1.user_id and 
            U1.session_id <> 0 and
            T.SUB_ID = U1.SUB_ID AND
            T.INSTITUTE_ID = '''|| p_inst ||''' AND
            T.AC_YEAR_ID = '''|| V('APP_ACADEMIC') ||'''
            AND U1.STD_ID = '''|| p_std_id ||'''
            AND U1.TEST_FK = '''|| p_test_id ||'''
        GROUP BY  T.test_pk, u1.result,U1.STD_ID,U1.SUB_ID,U1.STUDENT_ID,u1.test_date
        ORDER BY T.TEST_PK';

        open t_rc for t_query;
        as_pdf3.WRITE(' ' , 32, 550, p_alignment => 'left');
        as_pdf3.refcursor2table( t_rc );

    l_pdf_doc := as_pdf3.get_pdf;
    
    owa_util.mime_header( 'application/pdf', false );
    sys.htp.print( 'Content-Length: ' || dbms_lob.getlength( l_pdf_doc ) );
    sys.htp.print( 'Content-Disposition:  attachment; filename="' || v_file_name || '"' );
    sys.htp.print( 'Content-Description: Generated by as_pdf3' );
    owa_util.http_header_close;
    
    sys.wpg_docload.download_file( l_pdf_doc );
    apex_application.stop_apex_engine;
END;

    /*--as_pdf3.horizontal_line( 60, 485, 460, 1);
    as_pdf3.set_font( 'helvetica', 'b',11); 
    as_pdf3.WRITE('Student Name' , 32, 560, p_alignment => 'left');
    as_pdf3.WRITE('Test Date' , 130, p_alignment => 'left');
    as_pdf3.WRITE('No of Correct' ,230, p_alignment => 'left'); 
    as_pdf3.WRITE('No of Incorrect' ,330, p_alignment => 'left'); 
    as_pdf3.WRITE('Score' ,400, p_alignment => 'left'); 
    as_pdf3.WRITE('Result' ,500, p_alignment => 'left'); 
    
    as_pdf3.horizontal_line( 29, 575, 536, 1);
    as_pdf3.horizontal_line( 29, 555, 536, 1);

    as_pdf3.vertical_line( 29 , 555, 20, 1 );
    as_pdf3.vertical_line( 120 ,555, 20, 1 );
    as_pdf3.vertical_line( 220 ,555, 20, 1 );
    as_pdf3.vertical_line( 300 ,555, 20, 1 );
    as_pdf3.vertical_line( 400 ,555, 20, 1 );
    as_pdf3.vertical_line( 565 ,555, 20, 1 );
    */

---------------------------------------------------------
--PRINT REPORT CARD--
---------------------------------------------------------

procedure print_report_card (p_stud_id in number, p_inst in number)
IS
    INM VARCHAR2(50);
    IADD VARCHAR2(500);
    ICITY VARCHAR2(50);
    IMAIL VARCHAR2(100);
    IPH VARCHAR2(100);
    ACA VARCHAR2(50);
    l_pdf_doc blob;
    v_file_name varchar2(30) := 'Report_Card';
    SNM VARCHAR2(50);
    RNO NUMBER;
    STD VARCHAR2(10);
    SEM VARCHAR2(10);
    t_rc sys_refcursor;
    t_query varchar2(3000);
    t_heading varchar2(3000);
BEGIN
    SELECT INSTITUTE_NAME,INST_ADDRESS,INST_CITY,EMAIL,TEL_PHONE_NO
    INTO INM,IADD,ICITY,IMAIL,IPH
    FROM INSTITUTE_MST WHERE INSTITUTE_ID = p_inst;

    SELECT YEAR_NAME INTO ACA FROM ACADEMIC_YEAR_MST WHERE AC_YEAR_ID = v('APP_ACADEMIC');
    
    as_pdf3.init;
    as_pdf3.set_page_orientation('PORTRAIT');
    as_pdf3.set_font( 'times', 'b' ,16);
    as_pdf3.set_color(255,0,0);
    as_pdf3.WRITE(UPPER(INM), -1, -1, p_alignment => 'center');
    as_pdf3.set_font( 'helvetica' ,12); 
    as_pdf3.set_color('#00000');
    as_pdf3.WRITE('Address: ' || IADD || ' , ' || ICITY, -1, 705 , p_alignment => 'center'); 
    as_pdf3.WRITE('Email: ' || IMAIL, -1, -2, p_alignment => 'center'); 
    as_pdf3.WRITE('Telephone No: ' || IPH,-1, -2, p_alignment => 'center'); 
    as_pdf3.horizontal_line( 60, 670, 460, 1);

    as_pdf3.WRITE('Academic Year: ' || ACA ,60, 650, p_alignment => 'left'); 
    as_pdf3.WRITE('Date: ' || SYSDATE, 400, p_alignment => 'left'); 
    as_pdf3.horizontal_line( 60, 637, 460, 1);

    SELECT FIRSTNAME || ' ' || MIDDLENAME || ' ' ||LASTNAME, 
        ROLL_NO, 
        (SELECT STD_NAME FROM STANDARD_MST WHERE STD_ID = STUDENTS_DET.CUR_STD), 
        (SELECT SEM_NAME FROM SEMESTER_MST WHERE SEM_ID = STUDENTS_DET.CUR_SEM)
    INTO SNM, RNO, STD, SEM
    FROM STUDENTS_DET 
    WHERE STUDENT_ID = p_stud_id
        AND INSTITUTE_ID = p_inst
        AND AC_YEAR_ID = V('APP_ACADEMIC');

    as_pdf3.WRITE('Student Name: ' || SNM ,60 , 620, p_alignment => 'left'); 
    as_pdf3.WRITE('Roll No: '  || RNO, 400, p_alignment => 'left'); 
    as_pdf3.WRITE('Standard: ' || STD, 60 , 600, p_alignment => 'left'); 
    as_pdf3.WRITE('Semester: ' || SEM, 400, p_alignment => 'left'); 
    as_pdf3.horizontal_line( 60, 590, 460, 1);

    --as_pdf3.horizontal_line( 60, 550, 460, 1);
    as_pdf3.WRITE(' ',60,570);
    as_pdf3.set_font( 'helvetica', 'b', 12); 
    t_heading := 'SELECT ''Subjects'', ''Total Marks'',''Obtained Marks'',''Status'' FROM DUAL';
    as_pdf3.query2table( t_heading );

    t_query := 'SELECT (SELECT SUBJECT_NAME FROM SUBJECT_MST WHERE SUB_ID = TI.SUB_ID) AS SUB_ID,
        SUM(EQ.MARK_VALUE) AS TOTAL_MARKS,
        (SELECT SUM(SCORE) FROM TMS.EMS_TEST_INFO WHERE STUDENT_ID = '''|| p_stud_id ||''' GROUP BY SUB_ID) AS MARKS_OBTAINED,
        DECODE(TI.RESULT,1, ''Pass'', 2,''Fail'') AS STATUS
        FROM TMS.EMS_TEST_INFO TI , TMS.EMS_QUESTION_BANK EQ, TMS.EMS_TEST_QUES ET
        WHERE EQ.QID_PK = ET.QID_FK
            AND ET.TEST_FK = TI.TEST_FK
            AND TI.STUDENT_ID = '''|| p_stud_id ||'''
            AND TI.INSTITUTE_ID = '''|| p_inst ||'''
            AND TI.AC_YEAR_ID = V(''APP_ACADEMIC'')
            AND TI.STATUS = 2
        GROUP BY TI.STUDENT_ID, TI.SUB_ID,TI.RESULT';

    open t_rc for t_query;
    as_pdf3.set_font( 'helvetica', 12); 
    as_pdf3.WRITE(' ' , 32, 550, p_alignment => 'left');
    as_pdf3.refcursor2table( t_rc );
    l_pdf_doc := as_pdf3.get_pdf;
    
    owa_util.mime_header( 'application/pdf', false );
    sys.htp.print( 'Content-Length: ' || dbms_lob.getlength( l_pdf_doc ) );
    sys.htp.print( 'Content-Disposition:  attachment; filename="' || v_file_name || '"' );
    sys.htp.print( 'Content-Description: Generated by as_pdf3' );
    owa_util.http_header_close;
    
    sys.wpg_docload.download_file( l_pdf_doc );
    apex_application.stop_apex_engine;
END;
---------------------------------------------------------

procedure invoice_receipt(
    p_comp in varchar2 default null,
    p_street in varchar2 default null,
    p_addr in varchar2 default null,
    p_telno in varchar2 default null,
    p_country in varchar2 default null,
    p_vat_no in varchar2 default null,
    p_comp_reg_no in varchar2 default null,
    p_invoice_attn in varchar2 default null,
    p_invoice_nm in varchar2 default null,
    p_invoice_mail in varchar2 default null,
    p_invoice_no in number default null,
    p_date in date default null,
    p_due_date in date default null,
    p_test_plan in varchar2 default null,
    p_rate in varchar2 default null,
    p_tax in varchar2 default null,
    p_total_due in varchar2 default null
)
AS
    l_pdf_doc blob;
    v_file_name varchar2(30) := 'Invoice_Receipt';
    SPHOTO BLOB;
BEGIN
    SELECT STUD_PHOTO INTO SPHOTO FROM STUDENTS_DET WHERE STUDENT_ID = 87;
    as_pdf3.init;
    as_pdf3.set_page_proc( q'~
    begin
        as_pdf3.put_image(p_img=>SPHOTO,
            
            p_align => 'center',
            p_valign => 'top');
    ~' );
    as_pdf3.set_page_orientation('PORTRIAT');
    as_pdf3.set_margins( p_top => 500, p_left => 700, p_bottom => 30, p_right => 300);
    --as_pdf3.set_page_size( p_width => 100, p_height => 100);
    as_pdf3.set_font( 'times', 14);
    --https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Pleiades_large.jpg/800px-Pleiades_large.jpg
    --as_pdf3.put_image('https://www.oracleapexconsultant.com/wp-content/uploads/2019/11/APEX-logo-final-pro.png', 30, 750);
    --as_pdf3.put_image(p_img=>SPHOTO, p_x=>60, p_y=>500);
    as_pdf3.WRITE( p_comp, -1, 750, p_alignment => 'center');
    as_pdf3.WRITE( p_street, -1, 735 , p_alignment => 'center'); 
    as_pdf3.WRITE( p_addr, -1, 720, p_alignment => 'center');
    as_pdf3.WRITE( p_telno, -1, 705 , p_alignment => 'center');
    as_pdf3.WRITE( p_country, -1, 690, p_alignment => 'center'); 
    as_pdf3.WRITE( p_vat_no, -1, 675, p_alignment => 'center'); 
    as_pdf3.WRITE( p_comp_reg_no, -1, 660, p_alignment => 'center'); 

    as_pdf3.WRITE( 'INVOICE TO: ', 30, p_y => 590, p_alignment => 'left'); 
    as_pdf3.WRITE( 'Attn: ' || p_invoice_attn, 145, 590, p_alignment => 'left'); 
    as_pdf3.WRITE( p_invoice_nm, 145, 575, p_alignment => 'left'); 
    as_pdf3.WRITE( p_invoice_mail, 145, 560, p_alignment => 'left'); 

    as_pdf3.WRITE( 'Invoice No: ' || p_invoice_no, p_y => 590, p_alignment => 'right'); 
    as_pdf3.WRITE( 'Date: ' || p_date, p_y => 575, p_alignment => 'right'); 
    as_pdf3.WRITE( 'Due Date: ' || p_due_date, p_y => 560, p_alignment => 'right'); 

    as_pdf3.WRITE( p_test_plan, 30, 500, p_alignment => 'left');
    as_pdf3.WRITE( p_rate, 40, 500, p_alignment => 'right');

    as_pdf3.WRITE( 'TAX: ' , 192, 450, p_alignment => 'center');
    as_pdf3.WRITE( p_tax , 40, 450, p_alignment => 'right');
    as_pdf3.WRITE( 'TOTAL DUE: ', 150, 435, p_alignment => 'center');
    as_pdf3.WRITE( p_due_date , 40, 435, p_alignment => 'right');


    l_pdf_doc := as_pdf3.get_pdf;
   
    owa_util.mime_header( 'application/pdf', false );
    sys.htp.print( 'Content-Length: ' || dbms_lob.getlength( l_pdf_doc ) );
    sys.htp.print( 'Content-Disposition:  attachment; filename="' || v_file_name || '"' );
    sys.htp.print( 'Content-Description: Generated by as_pdf3' );
    owa_util.http_header_close;
        
    sys.wpg_docload.download_file( l_pdf_doc );
    apex_application.stop_apex_engine;

end invoice_receipt;

END DOWNLOAD_PKG;

/
