--------------------------------------------------------
--  DDL for Procedure TRAINING_ESTIMATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INSTITUTE"."TRAINING_ESTIMATE" (
	p_emp_id in number, 
	p_int_sdate in varchar2, 
	p_int_edate in varchar2, 
	p_inst_name in varchar2,
	p_proj_name in varchar2,
	p_degree in varchar2,
	p_comp_id in number)
IS
    l_emp_name VARCHAR2(100);
	l_addr VARCHAR2(500);
	l_state VARCHAR2(500);
	l_city VARCHAR2(500);
	l_est_no NUMBER := 145;
	l_initial_pg_size NUMBER;
    l_page_break NUMBER;
	l_file_name VARCHAR(100) := 'Internship Completion Letter.pdf';
	l_pdf_doc BLOB;
	l_comp_img BLOB;
	l_comp_logo BLOB;
	t_rc sys_refcursor;
	t_query varchar2(1000);
BEGIN
    SELECT FIRSTNAME || ' ' || MIDDLENAME || ' ' || LASTNAME, 
		ADDRESS,
       	(SELECT STATE_NAME FROM OMS_STATE_MST WHERE STATE_ID = OMS_EMP_DETAILS.STATE_ID) AS STATE,
	   	CITY
    INTO l_emp_name, l_addr, l_state, l_city
    FROM OMS_EMP_DETAILS 
	WHERE EMPLOYEE_ID = p_emp_id
		AND COMP_ID = p_comp_id;
    
    as_pdf3.init;
	l_initial_pg_size := 800;
	as_pdf3.set_page_format('A4');
    as_pdf3.set_page_orientation('PORTRAIT');
	as_pdf3.set_margins(p_top => 2, p_left => 2, p_bottom => 0, p_right => 2, p_unit => 'cm');

	SELECT FILE_CONTENT INTO l_comp_img
	FROM APEX_APPLICATION_STATIC_FILES 
	WHERE APPLICATION_ID = 100 
		AND FILE_NAME = 'APEX-logo-final-pro.png';

	SELECT FILE_CONTENT INTO l_comp_logo
	FROM APEX_APPLICATION_STATIC_FILES 
	WHERE APPLICATION_ID = 100 
		AND FILE_NAME = 'OAC logo.jpg';

	l_page_break := 30;
		
	as_pdf3.put_image(
    	p_img => l_comp_img,
    	p_x => 50,
    	p_y => l_initial_pg_size - l_page_break,
    	p_width => 300,
    	p_height => 50,
		p_align => 'start',
    	p_valign => 'top');

	l_page_break := l_page_break + 50;
    as_pdf3.set_font('times', 'B' ,18);
    as_pdf3.WRITE('ESTIMATE', 
		-1,
		l_initial_pg_size - l_page_break,
		p_alignment => 'left');
	
	l_page_break := l_page_break + 20;
	as_pdf3.put_image(
    	p_img => l_comp_logo,
    	p_x => 450,
    	p_y => l_initial_pg_size - l_page_break,
    	p_width => 70,
    	p_height => 50,
		p_align => 'start',
    	p_valign => 'top');
 
	l_page_break := l_page_break + 40;
	as_pdf3.set_font('times', 'B', 12);
    as_pdf3.WRITE(
		'ORACLE APEX CONSULTANT',
		-1, 
		l_initial_pg_size - l_page_break, 
		p_alignment => 'left');
	
	as_pdf3.set_font('times', 'N', 12);
    as_pdf3.WRITE('150ft Ring Road,', -1, -1, p_alignment => 'left'); 
	as_pdf3.WRITE(TO_CHAR(SYSDATE,'DD Mon, YYYY'), null, null, p_alignment => 'right');

	as_pdf3.WRITE('Rajkot, Gujarat - 360005, India', -1, -1, p_alignment => 'left'); 
	as_pdf3.WRITE('training@oracleapexconsultant.com', -1, -1, p_alignment => 'left'); 
	as_pdf3.WRITE('ESTIMATE# ' || l_est_no, null, null, p_alignment => 'right');

	as_pdf3.WRITE('+91-99251 71085', -1, -1, p_alignment => 'left'); 
	
	l_page_break := l_page_break + 90; 
	as_pdf3.set_font('times', 'B', 12);
    as_pdf3.WRITE('Quotation For',
		-1, 
		l_initial_pg_size - l_page_break, 
		p_alignment => 'left');
	
	as_pdf3.set_font('times', 'N', 12);
	l_page_break := l_page_break + 4; 
	as_pdf3.horizontal_line(55, l_initial_pg_size - l_page_break, 200, 1); 

	l_page_break := l_page_break + 12;
	as_pdf3.WRITE('Client: ', 
		-1, 
		l_initial_pg_size - l_page_break, 
		p_alignment => 'left');

	as_pdf3.WRITE('Email: ', 
		-1, 
		-1, 
		p_alignment => 'left');  

	as_pdf3.WRITE('Mobile No: ', 
		-1, 
		-1,
		p_alignment => 'left'); 
	
	l_page_break := l_page_break + 80;
	t_query := 'SELECT ''DESCRIPTION'',''QTY'',''UNIT_PRICE'',''TOTAL'' FROM DUAL';
	open t_rc for t_query;
	as_pdf3.refcursor2table( t_rc );

	l_page_break := l_page_break + 5;
	t_query := 'SELECT ''OAW (Oracle Application Express Workshop – I, II and Administration) 
			[ Training for 50-60 Hours]'',
			''03'',
			''10,000/-'',
			''10,000/-'' 
		FROM DUAL';
	open t_rc for t_query;
	as_pdf3.refcursor2table( t_rc );
	
/*
	l_page_break := l_page_break + 60; 
	as_pdf3.WRITE('Wishing you all the best.', 
		-1, 
		l_initial_pg_size - l_page_break, 
		p_alignment => 'left');

	l_page_break := l_page_break + 70; 
	as_pdf3.WRITE('For OracleAPEXConsultant,', 
		-1, 
		l_initial_pg_size - l_page_break, 
		p_alignment => 'left');
	
	l_page_break := l_page_break + 50; 
	as_pdf3.set_font('times', 'B', 12); 
	as_pdf3.WRITE('Dr.Digvijaysinh D Virpura', 
		-1, 
		l_initial_pg_size - l_page_break, 
		p_alignment => 'left');

	l_page_break := l_page_break + 20; 
	as_pdf3.set_font('times', 'N', 12); 
	as_pdf3.WRITE('Coordinator OracleAPEXConsultant Educational Wing', 
		-1, 
		l_initial_pg_size - l_page_break, 
		p_alignment => 'left');

*/

	---------------------------FOOTER---------------------------------
	
	as_pdf3.set_font('helvetica', 'B', 9);
	as_pdf3.WRITE('www.oracleapexconsultant.com',
		-1,
		40,
	p_alignment => 'left');

	as_pdf3.set_font('helvetica', 'BI', 9);
	as_pdf3.WRITE('©2022 ORACLE APEX CONSULTANT',
		-1,
		null,
	p_alignment => 'right');

    l_pdf_doc := as_pdf3.get_pdf;
    
    owa_util.mime_header( 'application/pdf', false );
    sys.htp.print('Content-Length: ' || dbms_lob.getlength( l_pdf_doc ) );
    sys.htp.print('Content-Disposition:  attachment; filename="' || l_file_name || '"' );
    sys.htp.print('Content-Description: Generated by as_pdf3' );
    owa_util.http_header_close;
    
    sys.wpg_docload.download_file( l_pdf_doc );
    apex_application.stop_apex_engine;

END training_estimate;

/
