--------------------------------------------------------
--  DDL for Package Body EMS_MODULE_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."EMS_MODULE_UTIL" IS

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
				AND MM.USER_TYPE_ID = EMS_UTIL.get_usertypeid(''PAR'', '||l_inst_id||')
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
				AND MM.USER_TYPE_ID = EMS_UTIL.get_usertypeid(''STUD'', '||l_inst_id||')
				AND (EMM.AUTH_SCHEME = ''STUDENT_RIGHTS''
					OR EMM.AUTH_SCHEME = ''PAR_STUD_RIGHTS''
					OR EMM.AUTH_SCHEME IS NULL)
			START WITH PARENT_ENTRY IS NULL
			CONNECT BY PRIOR MODULE_NM = PARENT_ENTRY 
			ORDER BY SEQ_ORDER';
		RETURN l_query;
	END IF;
END;

------------------------------------------------------------------------------------------------
--------------------------------Assign all modules to Institute---------------------------------
------------------------------------------------------------------------------------------------
procedure assign_all_modules(p_inst_id IN NUMBER)
IS
	l_adm_utype NUMBER;
	l_emp_utype NUMBER;
	l_par_utype NUMBER;
	l_stud_utype NUMBER;
	l_mod_nm VARCHAR2(100);
BEGIN

	------ADMIN MODULES-------
	FOR I IN (SELECT MODULE_NM, MODULE_ID
		FROM EMS_MODULE_MST
		WHERE MODULE_LEVEL = 1
			AND (AUTH_SCHEME = 'SUPADMIN_ADMIN_RIGHTS' 
			OR AUTH_SCHEME = 'ADMIN_RIGHTS' 
			OR AUTH_SCHEME = 'SADMIN_ADMIN_EMP_RIGHTS'
			OR AUTH_SCHEME = 'SADMIN_ADMIN_PAR_RIGHTS'
			OR AUTH_SCHEME IS NULL) 
		ORDER BY SEQ_ORDER)
	LOOP
		l_adm_utype := EMS_UTIL.get_usertypeid('ADM', p_inst_id);
		
		INSERT INTO EMS_MODULE_MAPPING(USER_TYPE_ID, MODULE_ID, INSTITUTE_ID, STATUS)
		VALUES(l_adm_utype, I.MODULE_ID, p_inst_id, 'Inactive');

		--Insert Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = I.MODULE_ID;

		FOR J IN (SELECT MODULE_ID FROM EMS_MODULE_MST 
			WHERE PARENT_ENTRY = l_mod_nm 
				AND (AUTH_SCHEME = 'SUPADMIN_ADMIN_RIGHTS' 
				OR AUTH_SCHEME = 'ADMIN_RIGHTS' 
				OR AUTH_SCHEME = 'SADMIN_ADMIN_EMP_RIGHTS'
				OR AUTH_SCHEME = 'SADMIN_ADMIN_PAR_RIGHTS'
				OR AUTH_SCHEME IS NULL))
		LOOP
			INSERT INTO EMS_MODULE_MAPPING(USER_TYPE_ID, MODULE_ID, INSTITUTE_ID, STATUS)
			VALUES(l_adm_utype, J.MODULE_ID, p_inst_id, 'Inactive');
		END LOOP;
	END LOOP;

	------EMPLOYEE MODULES-------
	FOR I IN (SELECT MODULE_NM, MODULE_ID
		FROM EMS_MODULE_MST
		WHERE MODULE_LEVEL = 1
			AND (AUTH_SCHEME = 'EMPLOYEE_RIGHTS' 
			OR AUTH_SCHEME = 'SADMIN_ADMIN_EMP_RIGHTS' 
			OR AUTH_SCHEME IS NULL) 
		ORDER BY SEQ_ORDER)
	LOOP
		l_emp_utype := EMS_UTIL.get_usertypeid('EMP', p_inst_id);
		
		INSERT INTO EMS_MODULE_MAPPING(USER_TYPE_ID, MODULE_ID, INSTITUTE_ID, STATUS)
		VALUES(l_emp_utype, I.MODULE_ID, p_inst_id, 'Inactive');

		--Insert Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = I.MODULE_ID;

		FOR J IN (SELECT MODULE_ID FROM EMS_MODULE_MST 
			WHERE PARENT_ENTRY = l_mod_nm 
				AND (AUTH_SCHEME = 'EMPLOYEE_RIGHTS' 
				OR AUTH_SCHEME = 'SADMIN_ADMIN_EMP_RIGHTS' 
				OR AUTH_SCHEME IS NULL))
		LOOP
			INSERT INTO EMS_MODULE_MAPPING(USER_TYPE_ID, MODULE_ID, INSTITUTE_ID, STATUS)
			VALUES(l_emp_utype, J.MODULE_ID, p_inst_id, 'Inactive');
		END LOOP;
	END LOOP;

	------PARENTS MODULES-------
	FOR I IN (SELECT MODULE_NM, MODULE_ID
		FROM EMS_MODULE_MST 
		WHERE MODULE_LEVEL = 1
			AND (AUTH_SCHEME = 'PAR_STUD_RIGHTS' 
			OR AUTH_SCHEME = 'PARENTS_RIGHTS' 
			OR AUTH_SCHEME = 'SADMIN_ADMIN_PAR_RIGHTS'
			OR AUTH_SCHEME IS NULL) 
		ORDER BY SEQ_ORDER)
	LOOP
		l_par_utype := EMS_UTIL.get_usertypeid('PAR', p_inst_id);
		
		INSERT INTO EMS_MODULE_MAPPING(USER_TYPE_ID, MODULE_ID, INSTITUTE_ID, STATUS)
		VALUES(l_par_utype, I.MODULE_ID, p_inst_id, 'Inactive');

		--Insert Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = I.MODULE_ID;

		FOR J IN (SELECT MODULE_ID FROM EMS_MODULE_MST 
			WHERE PARENT_ENTRY = l_mod_nm 
				AND (AUTH_SCHEME = 'PAR_STUD_RIGHTS' 
				OR AUTH_SCHEME = 'PARENTS_RIGHTS' 
				OR AUTH_SCHEME = 'SADMIN_ADMIN_PAR_RIGHTS'
				OR AUTH_SCHEME IS NULL) )
		LOOP
			INSERT INTO EMS_MODULE_MAPPING(USER_TYPE_ID, MODULE_ID, INSTITUTE_ID, STATUS)
			VALUES(l_par_utype, J.MODULE_ID, p_inst_id, 'Inactive');
		END LOOP;
	END LOOP;

	------STUDENT MODULES-------
	FOR I IN (SELECT MODULE_NM, MODULE_ID 
		FROM EMS_MODULE_MST 
		WHERE MODULE_LEVEL = 1
			AND (AUTH_SCHEME = 'STUDENT_RIGHTS' 
			OR AUTH_SCHEME = 'PAR_STUD_RIGHTS' 
			OR AUTH_SCHEME IS NULL) 
		ORDER BY SEQ_ORDER)
	LOOP
		l_stud_utype := EMS_UTIL.get_usertypeid('STUD', p_inst_id);
		
		INSERT INTO EMS_MODULE_MAPPING(USER_TYPE_ID, MODULE_ID, INSTITUTE_ID, STATUS)
		VALUES(l_stud_utype, I.MODULE_ID, p_inst_id, 'Inactive');

		--Insert Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = I.MODULE_ID;

		FOR J IN (SELECT MODULE_ID FROM EMS_MODULE_MST 
			WHERE PARENT_ENTRY = l_mod_nm 
				AND (AUTH_SCHEME = 'STUDENT_RIGHTS' 
			OR AUTH_SCHEME = 'PAR_STUD_RIGHTS' 
			OR AUTH_SCHEME IS NULL))
		LOOP
			INSERT INTO EMS_MODULE_MAPPING(USER_TYPE_ID, MODULE_ID, INSTITUTE_ID, STATUS)
			VALUES(l_stud_utype, J.MODULE_ID, p_inst_id, 'Inactive');
		END LOOP;
	END LOOP;
END assign_all_modules;

------------------------------------------------------------------------------------------------
------------------------Choose modules from assigned onces for Institute------------------------
------------------------------------------------------------------------------------------------
procedure choose_modules(
	p_start_date IN VARCHAR2, 
	p_end_date IN VARCHAR2, 
	p_admin_mod IN VARCHAR2, 
	p_emp_mod IN VARCHAR2,
	p_par_mod IN VARCHAR2, 
	p_stud_mod IN VARCHAR2, 
	p_inst_id IN NUMBER)
IS
	l_adm_utype NUMBER;
	l_emp_utype NUMBER;
	l_par_utype NUMBER;
	l_stud_utype NUMBER;
	l_mod_nm VARCHAR2(100);
BEGIN
	------Update Dates of all records in Module Mapping--------
	UPDATE EMS_MODULE_MAPPING
	SET START_DATE = p_start_date,
		END_DATE = p_end_date
	WHERE INSTITUTE_ID = p_inst_id;

	------ADMIN MODULES-------
	FOR I IN (SELECT * FROM TABLE(APEX_STRING.SPLIT(p_admin_mod,':')))
	LOOP
		l_adm_utype := EMS_UTIL.get_usertypeid('ADM', p_inst_id);

		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Active',
			START_DATE = p_start_date,
			END_DATE = p_end_date
		WHERE MODULE_ID = I.COLUMN_VALUE
			AND USER_TYPE_ID = l_adm_utype
			AND INSTITUTE_ID = p_inst_id;

		--Update Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = I.COLUMN_VALUE;

		FOR J IN (SELECT MODULE_ID FROM EMS_MODULE_MST WHERE PARENT_ENTRY = l_mod_nm)
		LOOP
			UPDATE EMS_MODULE_MAPPING
			SET STATUS = 'Active',
				START_DATE = p_start_date,
				END_DATE = p_end_date
			WHERE MODULE_ID = J.MODULE_ID
				AND USER_TYPE_ID = l_adm_utype
				AND INSTITUTE_ID = p_inst_id;
		END LOOP;
	END LOOP;

	------EMPLOYEE MODULES-------
	FOR I IN (SELECT * FROM TABLE(APEX_STRING.SPLIT(p_emp_mod,':')))
	LOOP
		l_emp_utype := EMS_UTIL.get_usertypeid('EMP', p_inst_id);
	
		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Active',
			START_DATE = p_start_date,
			END_DATE = p_end_date
		WHERE MODULE_ID = I.COLUMN_VALUE
			AND USER_TYPE_ID = l_emp_utype
			AND INSTITUTE_ID = p_inst_id;

		--Insert Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = I.COLUMN_VALUE;

		FOR J IN (SELECT MODULE_ID FROM EMS_MODULE_MST WHERE PARENT_ENTRY = l_mod_nm)
		LOOP
			UPDATE EMS_MODULE_MAPPING
			SET STATUS = 'Active',
				START_DATE = p_start_date,
				END_DATE = p_end_date
			WHERE MODULE_ID = J.MODULE_ID
				AND USER_TYPE_ID = l_emp_utype
				AND INSTITUTE_ID = p_inst_id;
		END LOOP;
	END LOOP;

	------PARENTS MODULES-------
	FOR I IN (SELECT * FROM TABLE(APEX_STRING.SPLIT(p_par_mod,':')))
	LOOP
		l_par_utype := EMS_UTIL.get_usertypeid('PAR', p_inst_id);
		
		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Active',
			START_DATE = p_start_date,
			END_DATE = p_end_date
		WHERE MODULE_ID = I.COLUMN_VALUE
			AND USER_TYPE_ID = l_par_utype
			AND INSTITUTE_ID = p_inst_id;

		--Insert Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = I.COLUMN_VALUE;

		FOR J IN (SELECT MODULE_ID FROM EMS_MODULE_MST WHERE PARENT_ENTRY = l_mod_nm)
		LOOP
			UPDATE EMS_MODULE_MAPPING
			SET STATUS = 'Active',
				START_DATE = p_start_date,
				END_DATE = p_end_date
			WHERE MODULE_ID = J.MODULE_ID
				AND USER_TYPE_ID = l_par_utype
				AND INSTITUTE_ID = p_inst_id;
		END LOOP;
	END LOOP;

	------STUDENT MODULES-------
	FOR I IN (SELECT * FROM TABLE(APEX_STRING.SPLIT(p_stud_mod,':')))
	LOOP
		l_stud_utype := EMS_UTIL.get_usertypeid('STUD', p_inst_id);
		
		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Active',
			START_DATE = p_start_date,
			END_DATE = p_end_date
		WHERE MODULE_ID = I.COLUMN_VALUE
			AND USER_TYPE_ID = l_stud_utype
			AND INSTITUTE_ID = p_inst_id;

		--Insert Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = I.COLUMN_VALUE;

		FOR J IN (SELECT MODULE_ID FROM EMS_MODULE_MST WHERE PARENT_ENTRY = l_mod_nm)
		LOOP
			UPDATE EMS_MODULE_MAPPING
			SET STATUS = 'Active',
				START_DATE = p_start_date,
				END_DATE = p_end_date
			WHERE MODULE_ID = J.MODULE_ID
				AND USER_TYPE_ID = l_stud_utype
				AND INSTITUTE_ID = p_inst_id;
		END LOOP;
	END LOOP;
END choose_modules;

------------------------------------------------------------------------------------------------
----------------------------------------Edit modules--------------------------------------------
------------------------------------------------------------------------------------------------
procedure edit_modules(
	p_admin_mod IN VARCHAR2, 
	p_emp_mod IN VARCHAR2,
	p_par_mod IN VARCHAR2,
	p_stud_mod IN VARCHAR2,
	p_inst_id IN NUMBER)
IS
	l_mod_nm VARCHAR2(100);
	l_adm_utype NUMBER;
	l_emp_utype NUMBER;
	l_par_utype NUMBER;
	l_stud_utype NUMBER;
BEGIN
	--=================Admin================--
	l_adm_utype := EMS_UTIL.get_usertypeid ('ADM', p_inst_id);

	FOR I IN (SELECT MODULE_ID FROM EMS_MODULE_MAPPING WHERE INSTITUTE_ID = p_inst_id AND USER_TYPE_ID = l_adm_utype)
	LOOP
		--APEX_DEBUG.INFO('==I.MOD_ID==' || I.MODULE_ID);
		--APEX_DEBUG.INFO('==User Type Id==' || l_adm_utype);

		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Inactive'
		WHERE MODULE_ID = I.MODULE_ID
			AND USER_TYPE_ID = l_adm_utype
			AND INSTITUTE_ID = p_inst_id;
	END LOOP;

	FOR J IN (SELECT * FROM APEX_STRING.SPLIT(p_admin_mod,':'))
    LOOP
		--APEX_DEBUG.INFO('==J.MOD_ID==' || J.COLUMN_VALUE);

		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Active'
		WHERE MODULE_ID = J.COLUMN_VALUE
			AND USER_TYPE_ID = l_adm_utype
			AND INSTITUTE_ID = p_inst_id;

		--Update Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = J.COLUMN_VALUE;

		FOR K IN (SELECT MODULE_ID FROM EMS_MODULE_MST WHERE PARENT_ENTRY = l_mod_nm)
		LOOP
			UPDATE EMS_MODULE_MAPPING
			SET STATUS = 'Active'
			WHERE MODULE_ID = K.MODULE_ID
				AND USER_TYPE_ID = l_adm_utype
				AND INSTITUTE_ID = p_inst_id;
		END LOOP;
    END LOOP;

	--=================Employee================--
	l_emp_utype := EMS_UTIL.get_usertypeid ('EMP', p_inst_id);
	
	FOR I IN (SELECT MODULE_ID FROM EMS_MODULE_MAPPING WHERE INSTITUTE_ID = p_inst_id AND USER_TYPE_ID = l_emp_utype)
	LOOP
		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Inactive'
		WHERE MODULE_ID = I.MODULE_ID
			AND USER_TYPE_ID = l_emp_utype
			AND INSTITUTE_ID = p_inst_id;
	END LOOP;

	FOR J IN (SELECT * FROM APEX_STRING.SPLIT(p_emp_mod,':'))
    LOOP
		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Active'
		WHERE MODULE_ID = J.COLUMN_VALUE
			AND USER_TYPE_ID = l_emp_utype
			AND INSTITUTE_ID = p_inst_id;

		--Update Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = J.COLUMN_VALUE;

		FOR K IN (SELECT MODULE_ID FROM EMS_MODULE_MST WHERE PARENT_ENTRY = l_mod_nm)
		LOOP
			UPDATE EMS_MODULE_MAPPING
			SET STATUS = 'Active'
			WHERE MODULE_ID = K.MODULE_ID
				AND USER_TYPE_ID = l_emp_utype
				AND INSTITUTE_ID = p_inst_id;
		END LOOP;
    END LOOP;

	--=================Parents================--
	l_par_utype := EMS_UTIL.get_usertypeid ('PAR', p_inst_id);

    FOR I IN (SELECT MODULE_ID FROM EMS_MODULE_MAPPING WHERE INSTITUTE_ID = p_inst_id AND USER_TYPE_ID = l_par_utype)
	LOOP
		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Inactive'
		WHERE MODULE_ID = I.MODULE_ID
			AND USER_TYPE_ID = l_par_utype
			AND INSTITUTE_ID = p_inst_id;
	END LOOP;

	FOR J IN (SELECT * FROM APEX_STRING.SPLIT(p_par_mod,':'))
    LOOP
		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Active'
		WHERE MODULE_ID = J.COLUMN_VALUE
			AND USER_TYPE_ID = l_par_utype
			AND INSTITUTE_ID = p_inst_id;

		--Update Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = J.COLUMN_VALUE;

		FOR K IN (SELECT MODULE_ID FROM EMS_MODULE_MST WHERE PARENT_ENTRY = l_mod_nm)
		LOOP
			UPDATE EMS_MODULE_MAPPING
			SET STATUS = 'Active'
			WHERE MODULE_ID = K.MODULE_ID
				AND USER_TYPE_ID = l_par_utype
				AND INSTITUTE_ID = p_inst_id;
		END LOOP;
    END LOOP;

	--=================Student================--
	l_stud_utype := EMS_UTIL.get_usertypeid ('STUD', p_inst_id);

    FOR I IN (SELECT MODULE_ID FROM EMS_MODULE_MAPPING WHERE INSTITUTE_ID = p_inst_id AND USER_TYPE_ID = l_stud_utype)
	LOOP
		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Inactive'
		WHERE MODULE_ID = I.MODULE_ID
			AND USER_TYPE_ID = l_stud_utype
			AND INSTITUTE_ID = p_inst_id;
	END LOOP;

	FOR J IN (SELECT * FROM APEX_STRING.SPLIT(p_stud_mod,':'))
    LOOP
		UPDATE EMS_MODULE_MAPPING
		SET STATUS = 'Active'
		WHERE MODULE_ID = J.COLUMN_VALUE
			AND USER_TYPE_ID = l_stud_utype
			AND INSTITUTE_ID = p_inst_id;

		--Update Child Menu--
		SELECT MODULE_NM INTO l_mod_nm
		FROM EMS_MODULE_MST 
		WHERE MODULE_ID = J.COLUMN_VALUE;

		FOR K IN (SELECT MODULE_ID FROM EMS_MODULE_MST WHERE PARENT_ENTRY = l_mod_nm)
		LOOP
			UPDATE EMS_MODULE_MAPPING
			SET STATUS = 'Active'
			WHERE MODULE_ID = K.MODULE_ID
				AND USER_TYPE_ID = l_stud_utype
				AND INSTITUTE_ID = p_inst_id;
		END LOOP;
    END LOOP;
END edit_modules;

END EMS_MODULE_UTIL;

/
