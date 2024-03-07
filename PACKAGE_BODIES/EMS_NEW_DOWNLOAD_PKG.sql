--------------------------------------------------------
--  DDL for Package Body EMS_NEW_DOWNLOAD_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."EMS_NEW_DOWNLOAD_PKG" as
    
procedure fees_receipt (p_stud_id in number, p_fees_id in number, p_inst in number, p_acyr_id in number)
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
    SELECT YEAR_NAME INTO ACA FROM ACADEMIC_YEAR_MST WHERE AC_YEAR_ID = p_acyr_id;
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
--PRINT RESULT--
---------------------------------------------------------
procedure result_printing (p_test_id in number, p_std_id in number, p_inst in number, p_acyr_id in number)
IS
    l_inst_nm VARCHAR2(50);
    l_inst_add VARCHAR2(500);
    l_inst_city VARCHAR2(50);
    l_inst_email VARCHAR2(100);
    l_inst_phone VARCHAR2(100);
    l_acayr_nm VARCHAR2(50);
	v_file_name VARCHAR2(30) := 'Print_Result.pdf';
    l_pdf_doc BLOB;
	l_initial_pg_size NUMBER;
    l_page_break NUMBER;
    t_rc sys_refcursor;
    t_query VARCHAR2(3000);
    t_heading VARCHAR2(3000);
BEGIN
    SELECT INSTITUTE_NAME,INST_ADDRESS,INST_CITY,EMAIL,TEL_PHONE_NO
    INTO l_inst_nm,l_inst_add,l_inst_city,l_inst_email,l_inst_phone
    FROM INSTITUTE_MST 
	WHERE INSTITUTE_ID = p_inst;

    SELECT YEAR_NAME INTO l_acayr_nm 
	FROM ACADEMIC_YEAR_MST 
	WHERE INSTITUTE_ID = p_inst
		AND AC_YEAR_ID = p_acyr_id;
		
    as_pdf3.init;
	l_initial_pg_size := 805;
    --as_pdf3.set_page_size(10,15, p_unit => 'cm');
    as_pdf3.set_font( 'times', 'b' ,16);
    as_pdf3.set_page_orientation('PORTRAIT');
	
	--===Institute Name===--
    as_pdf3.set_font( 'times', 'b' ,16);
    as_pdf3.set_color(255,0,0);
    as_pdf3.WRITE(UPPER(l_inst_nm), -1, -1, p_alignment => 'center');
	
	--===Institute Info===--
    as_pdf3.set_font( 'helvetica' ,12); 
    as_pdf3.set_color('#00000');
	
	l_page_break := 100;
    as_pdf3.WRITE('Address: ' || l_inst_add || ' , ' || l_inst_city, -1, l_initial_pg_size - l_page_break, p_alignment => 'center'); 
	
	l_page_break := l_page_break + 10; --110
    as_pdf3.WRITE('Email: ' || l_inst_email, -1, l_initial_pg_size - l_page_break, p_alignment => 'center'); 
	
	l_page_break := l_page_break + 10; --120
    as_pdf3.WRITE('Telephone No: ' || l_inst_phone,-1, l_initial_pg_size - l_page_break, p_alignment => 'center'); 
	
	l_page_break := l_page_break + 15; --135
    as_pdf3.horizontal_line( 60, l_initial_pg_size - l_page_break, 460, 1); --670
	
	l_page_break := l_page_break + 20; --155
    as_pdf3.WRITE('Academic Year: ' || l_acayr_nm , 60, l_initial_pg_size - l_page_break, p_alignment => 'left'); --650
    as_pdf3.WRITE('Date: ' || SYSDATE, 400, p_alignment => 'left'); 
	
	l_page_break := l_page_break + 15; --175
    as_pdf3.horizontal_line(60, l_initial_pg_size - l_page_break, 460, 1); --630

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
            T.AC_YEAR_ID = p_acyr_id AND
            U1.STD_ID = p_std_id AND
            U1.TEST_FK = p_test_id
        GROUP BY  T.test_pk, u1.result,U1.STD_ID,U1.SUB_ID,U1.STUDENT_ID,
            t.test_name, u1.test_date,t.TEST_TYPE
        ORDER BY T.TEST_PK)
    LOOP
	
		l_page_break := l_page_break + 10; --185
        as_pdf3.WRITE('Test Name: ' || I.TEST_NAME ,60 , l_initial_pg_size - l_page_break, p_alignment => 'left');  --620
        as_pdf3.WRITE('Test Type: ' || I.TESTTYP, 400, p_alignment => 'left'); 
		
		l_page_break := l_page_break + 20; --205
        as_pdf3.WRITE('Subject: ' || I.SUBNM, 60 , l_initial_pg_size - l_page_break, p_alignment => 'left'); --600
        as_pdf3.WRITE('Standard: ' || I.STDNM, 400, p_alignment => 'left'); 

		l_page_break := l_page_break + 20; --225		
        as_pdf3.WRITE('Subject: ' || I.STUDENT_NAME, 60 , l_initial_pg_size - l_page_break, p_alignment => 'left');  --580
        as_pdf3.WRITE('Roll No: ' || I.ROLL_NO, 400, p_alignment => 'left'); 
		
		l_page_break := l_page_break + 10; --235
        as_pdf3.horizontal_line( 60, l_initial_pg_size - l_page_break, 460, 1); --570
        
    END LOOP;

    as_pdf3.WRITE(' ' , 32, l_initial_pg_size - l_page_break, p_alignment => 'left'); 
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
            T.AC_YEAR_ID = '''|| p_acyr_id ||'''
            AND U1.STD_ID = '''|| p_std_id ||'''
            AND U1.TEST_FK = '''|| p_test_id ||'''
        GROUP BY  T.test_pk, u1.result,U1.STD_ID,U1.SUB_ID,U1.STUDENT_ID,u1.test_date
        ORDER BY T.TEST_PK';

        open t_rc for t_query;
		
		l_page_break := l_page_break + 20; --255
        as_pdf3.WRITE(' ' , 32, l_initial_pg_size - l_page_break, p_alignment => 'left'); --550
		
        as_pdf3.refcursor2table( t_rc );

    l_pdf_doc := as_pdf3.get_pdf;
    
    owa_util.mime_header( 'application/pdf', false );
    sys.htp.print( 'Content-Length: ' || dbms_lob.getlength( l_pdf_doc ) );
    sys.htp.print( 'Content-Disposition:  attachment; filename="' || v_file_name || '"' );
    sys.htp.print( 'Content-Description: Generated by as_pdf3' );
    owa_util.http_header_close;
    
    sys.wpg_docload.download_file( l_pdf_doc );
    apex_application.stop_apex_engine;

END result_printing;

---------------------------------------------------------
--PRINT REPORT CARD--
---------------------------------------------------------
procedure print_report_card (p_stud_id in number, p_inst in number, p_acyr_id in number)
IS
    l_inst_nm VARCHAR2(50);
    l_inst_addr VARCHAR2(500);
    l_inst_city VARCHAR2(50);
    l_inst_email VARCHAR2(100);
    l_inst_phone VARCHAR2(100);
    l_acyr_nm VARCHAR2(50);
    l_stud_nm VARCHAR2(50);
    l_rno NUMBER;
    l_std VARCHAR2(10);
    l_sem VARCHAR2(10);
	l_initial_pg_size NUMBER;
    l_page_break NUMBER;
	l_file_name varchar2(30) := 'Report_Card.pdf';
	l_pdf_doc blob;
    t_rc sys_refcursor;
    t_query varchar2(3000);
    t_heading varchar2(3000);
BEGIN
    SELECT INSTITUTE_NAME,INST_ADDRESS,INST_CITY,EMAIL,TEL_PHONE_NO
    INTO l_inst_nm, l_inst_addr, l_inst_city, l_inst_email, l_inst_phone
    FROM INSTITUTE_MST WHERE INSTITUTE_ID = p_inst;
	
    SELECT YEAR_NAME INTO l_acyr_nm 
	FROM ACADEMIC_YEAR_MST 
	WHERE AC_YEAR_ID = p_acyr_id;
    
    as_pdf3.init;
    as_pdf3.set_page_orientation('PORTRAIT');
	
    as_pdf3.set_font( 'times', 'b' ,16);
    as_pdf3.set_color(255,0,0);
    as_pdf3.WRITE(UPPER(l_inst_nm), -1, -1, p_alignment => 'center');
	
	as_pdf3.set_font( 'helvetica' ,12); 
    as_pdf3.set_color('#00000');
	
	l_page_break := 100;
    as_pdf3.WRITE('Address: ' || l_inst_addr || ' , ' || l_inst_city, -1, l_initial_pg_size - l_page_break, p_alignment => 'center'); --705
	
	l_page_break := l_page_break + 10; --110
    as_pdf3.WRITE('Email: ' || l_inst_email, -1, l_initial_pg_size - l_page_break, p_alignment => 'center'); 
	
	l_page_break := l_page_break + 10; --120
    as_pdf3.WRITE('Telephone No: ' || l_inst_phone,-1, l_initial_pg_size - l_page_break, p_alignment => 'center'); 
	
	l_page_break := l_page_break + 15; --135
    as_pdf3.horizontal_line( 60, l_initial_pg_size - l_page_break, 460, 1); --670
	
	l_page_break := l_page_break + 20; --155
    as_pdf3.WRITE('Academic Year: ' || l_acyr_nm , 60, l_initial_pg_size - l_page_break, p_alignment => 'left'); --650
    as_pdf3.WRITE('Date: ' || SYSDATE, 400, p_alignment => 'left'); 
	
	l_page_break := l_page_break + 15; --175
    as_pdf3.horizontal_line(60, l_initial_pg_size - l_page_break, 460, 1); --630

    SELECT FIRSTNAME || ' ' || MIDDLENAME || ' ' ||LASTNAME, 
        ROLL_NO, 
        (SELECT STD_NAME FROM STANDARD_MST WHERE STD_ID = STUDENTS_DET.CUR_STD), 
        (SELECT SEM_NAME FROM SEMESTER_MST WHERE SEM_ID = STUDENTS_DET.CUR_SEM)
    INTO l_stud_nm, l_rno, l_std, l_sem
    FROM STUDENTS_DET 
    WHERE STUDENT_ID = p_stud_id
        AND INSTITUTE_ID = p_inst
        AND AC_YEAR_ID = p_acyr_id;
	
	l_page_break := l_page_break + 10; --185
    as_pdf3.WRITE('Student Name: ' || l_stud_nm ,60 , l_initial_pg_size - l_page_break, p_alignment => 'left'); --620
    as_pdf3.WRITE('Roll No: '  || l_rno, 400, p_alignment => 'left'); 
	
	l_page_break := l_page_break + 20; --205
    as_pdf3.WRITE('Standard: ' || l_std, 60 , l_initial_pg_size - l_page_break, p_alignment => 'left'); --600
    as_pdf3.WRITE('Semester: ' || l_sem, 400, p_alignment => 'left'); 
	
	l_page_break := l_page_break + 10; --215
    as_pdf3.horizontal_line( 60, l_initial_pg_size - l_page_break, 460, 1); --590
    --as_pdf3.horizontal_line( 60, 550, 460, 1);
	
	l_page_break := l_page_break + 20; --235
    as_pdf3.WRITE(' ', 60, l_initial_pg_size - l_page_break); --570
    as_pdf3.set_font( 'helvetica', 'b', 12); 
    t_heading := 'SELECT ''Subjects'', ''Total Marks'',''Obtained Marks'',''Status'' FROM DUAL';
    as_pdf3.query2table( t_heading );
	
    t_query := 'SELECT 
					(SELECT SUBJECT_NAME FROM SUBJECT_MST WHERE SUB_ID = TI.SUB_ID) AS SUB_ID,
					SUM(EQ.MARK_VALUE) AS TOTAL_MARKS,
					(SELECT SUM(SCORE) FROM TMS.EMS_TEST_INFO WHERE STUDENT_ID = '''|| p_stud_id ||''' GROUP BY SUB_ID) AS MARKS_OBTAINED,
					DECODE(TI.RESULT,1, ''Pass'', 2,''Fail'') AS STATUS
				FROM TMS.EMS_TEST_INFO TI , TMS.EMS_QUESTION_BANK EQ, TMS.EMS_TEST_QUES ET
				WHERE EQ.QID_PK = ET.QID_FK
					AND ET.TEST_FK = TI.TEST_FK
					AND TI.STUDENT_ID = '''|| p_stud_id ||'''
					AND TI.INSTITUTE_ID = '''|| p_inst ||'''
					AND TI.AC_YEAR_ID = '''|| p_acyr_id ||'''
					AND TI.STATUS = 2
				GROUP BY TI.STUDENT_ID, TI.SUB_ID,TI.RESULT';
		
    open t_rc for t_query;
	
    as_pdf3.set_font( 'helvetica', 12); 
	
	l_page_break := l_page_break + 20; --255
    as_pdf3.WRITE(' ' , 32, l_initial_pg_size - l_page_break, p_alignment => 'left'); --550
    as_pdf3.refcursor2table( t_rc );
	
    l_pdf_doc := as_pdf3.get_pdf;
    
    owa_util.mime_header( 'application/pdf', false );
    sys.htp.print( 'Content-Length: ' || dbms_lob.getlength( l_pdf_doc ) );
    sys.htp.print( 'Content-Disposition:  attachment; filename="' || l_file_name || '"' );
    sys.htp.print( 'Content-Description: Generated by as_pdf3' );
    owa_util.http_header_close;
    
    sys.wpg_docload.download_file( l_pdf_doc );
    apex_application.stop_apex_engine;

END print_report_card;

END EMS_NEW_DOWNLOAD_PKG;

/
