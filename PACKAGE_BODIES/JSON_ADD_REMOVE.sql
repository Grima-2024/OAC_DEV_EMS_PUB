--------------------------------------------------------
--  DDL for Package Body JSON_ADD_REMOVE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."JSON_ADD_REMOVE" is

procedure add_json_mover (v_mover_id in varchar2, 
                        v_zip_code in varchar2, 
                        v_mul_zip in varchar2,
                        v_select_type in varchar2)
is
    l_element JSON_ELEMENT_T;
    l_marray JSON_ARRAY_T;
	l_mover varchar2(4000);
	movercnt varchar2(255);
	l_append varchar2(4000);
	l_element_append JSON_ELEMENT_T;
    r_cnt number;
    e_error exception;

BEGIN

	IF (v_select_type = 'se') THEN

        select COUNT(*) INTO r_cnt 
        from MOVERGEOG_JSON z, 
        json_table(z.MOVER_ID, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_mover_id AND ZIPCODE = v_zip_code;

        SELECT MOVER_ID into movercnt FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code; 
        SELECT MOVER_ID INTO l_append FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code;


        IF r_cnt = 0 THEN
		
            l_element := JSON_ELEMENT_T.parse('[0]'); 
            IF movercnt IS NULL THEN
                IF l_element.is_Array THEN
					l_marray := TREAT (l_element AS json_array_t);
					l_marray.put(0, v_mover_id);
					l_marray.remove(1);
					l_mover := l_marray.stringify;
					
					UPDATE MOVERGEOG_JSON
					SET MOVER_ID = l_mover
					WHERE ZIPCODE = v_zip_code;
                END IF;
            ELSE
                l_element_append := JSON_ELEMENT_T.parse(l_append); 
                IF l_element_append.is_Array THEN
                    l_marray := TREAT (l_element_append AS json_array_t);
                    l_marray.append(v_mover_id);
                    l_mover := l_marray.stringify;
                   
                    UPDATE MOVERGEOG_JSON
                    SET MOVER_ID = l_mover
                    WHERE ZIPCODE = v_zip_code;
                END IF;
            END IF;
		ELSE
			apex_util.set_session_state('P4_ERROR','Mover ID already exists within same Zip code');
            RAISE e_error;
		END IF;
	ELSE
		select COUNT(*) into r_cnt
        from MOVERGEOG_JSON z, 
        json_table(z.MOVER_ID, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_mover_id AND ZIPCODE IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')));

        IF r_cnt = 0 THEN

			FOR I IN ((SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':'))))
			LOOP
				FOR K IN (SELECT MOVER_ID FROM MOVERGEOG_JSON WHERE ZIPCODE = I.COLUMN_VALUE)
				LOOP
					IF K.MOVER_ID IS NULL THEN
						l_element_append := JSON_ELEMENT_T.parse('[0]'); 

						IF l_element_append.is_Array THEN
							l_marray := TREAT (l_element_append AS json_array_t);
							l_marray.put (0, v_mover_id);
							l_marray.remove(1);
						
							l_mover := l_marray.stringify;
						
							UPDATE MOVERGEOG_JSON
							SET MOVER_ID = l_mover
							WHERE ZIPCODE = I.COLUMN_VALUE;
						END IF;
					ELSE
						l_element_append := JSON_ELEMENT_T.parse(K.MOVER_ID); 

						IF l_element_append.is_Array THEN
							l_marray := TREAT (l_element_append AS json_array_t);
							l_marray.append(v_mover_id);
						
							l_mover := l_marray.stringify;
						
							UPDATE MOVERGEOG_JSON
							SET MOVER_ID = l_mover
							WHERE ZIPCODE = I.COLUMN_VALUE;
						END IF;
					END IF;
				END LOOP;
			 END LOOP;
        ELSE
            apex_util.set_session_state('P4_ERROR','Employee record already exists within one of the Zip code');
            RAISE e_error;
        END IF;
	END IF;
END add_json_mover;

---------------------------------------------REMOVE JSON DATA---------------------------------------------------------

procedure remove_json_mover (v_mover_id in varchar2, 
                            v_zip_code in varchar2, 
                            v_mul_zip in varchar2,
                            v_select_type in varchar2)
is
    l_element_append JSON_ELEMENT_T;
    l_mover varchar(4000);
    l_marray JSON_ARRAY_T;
    ELE_INDX NUMBER;
    l_uparray varchar(4000);
    e_error exception;
    r_cnt NUMBER;
	
BEGIN
	IF (v_select_type = 'se') THEN
	
        SELECT MOVER_ID INTO l_mover FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code;
        l_element_append := JSON_ELEMENT_T.parse(l_mover);
		
        IF l_element_append.is_Array THEN
            l_marray := TREAT (l_element_append AS json_array_t);
            SELECT RN INTO ELE_INDX
            FROM
            (
                SELECT VALUE,row_number() over (order by ZIPCODE) as rn
                FROM (select value,ZIPCODE from MOVERGEOG_JSON z, 
                                    json_table(z.MOVER_ID, '$[*]' COLUMNS (value PATH '$',rn for ordinality))) 
                WHERE ZIPCODE = v_zip_code
            )
            WHERE VALUE = v_mover_id;
                
            l_marray.remove(ELE_INDX - 1);
            l_uparray := l_marray.stringify;

            UPDATE MOVERGEOG_JSON
            SET MOVER_ID = l_uparray
            WHERE ZIPCODE = v_zip_code;
        END IF;
    ELSE    
        select COUNT(*) into r_cnt
        from MOVERGEOG_JSON z, 
        json_table(z.MOVER_ID, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_mover_id AND ZIPCODE IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')));

        --IF r_cnt > 0 THEN

            FOR I IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')))
            LOOP
                FOR K IN (SELECT MOVER_ID FROM MOVERGEOG_JSON WHERE ZIPCODE = I.COLUMN_VALUE)
                LOOP
                    l_element_append := JSON_ELEMENT_T.parse(K.MOVER_ID);
                    IF l_element_append.is_Array THEN
                        l_marray := TREAT (l_element_append AS json_array_t);
                        FOR J IN (SELECT RN
                            FROM
                            (
                                SELECT VALUE,ZIPCODE,row_number() over (PARTITION BY ZIPCODE order by ZIPCODE) as rn
								FROM (select value,ZIPCODE from MOVERGEOG_JSON z, 
													json_table(z.MOVER_ID, '$[*]' COLUMNS (value PATH '$',rn for ordinality))) 
								WHERE ZIPCODE = I.COLUMN_VALUE
                            )
                            WHERE VALUE = v_mover_id)
                        LOOP                    
                            l_marray.remove(J.RN - 1);
                            l_uparray := l_marray.stringify;

                            UPDATE MOVERGEOG_JSON
                            SET MOVER_ID = l_uparray
                            WHERE ZIPCODE = I.COLUMN_VALUE;
                        END LOOP;
                    END IF;
                END LOOP;
            END LOOP;
        --ELSE
         --   apex_util.set_session_state('P4_ERROR','Employee ID entered doesnot exists within of the Zip Code!');
         --   RAISE e_error;
        --END IF;
    END IF;	
END remove_json_mover;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

procedure add_json_vloc (v_verloc in varchar2, 
                        v_zip_code in varchar2, 
                        v_mul_zip in varchar2,
                        v_select_type in varchar2)
is
    l_element JSON_ELEMENT_T;
	l_vlocarray JSON_ARRAY_T;
	l_vloc varchar2(4000);
	vloccnt varchar2(255);
	l_vlappend varchar2(4000);
	l_element_append JSON_ELEMENT_T;
    r_cnt number;
    e_error exception;
BEGIN
	IF (v_select_type = 'se') THEN
	
		select COUNT(*) INTO r_cnt 
        from MOVERGEOG_JSON z, 
        json_table(z.VERIFIED_LOC, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_verloc AND ZIPCODE = v_zip_code;
		
		SELECT VERIFIED_LOC into vloccnt FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code; 
        SELECT VERIFIED_LOC INTO l_vlappend FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code;

  
		IF r_cnt = 0 THEN
			l_element := JSON_ELEMENT_T.parse('[0]');
			IF vloccnt IS NULL THEN
				IF l_element.is_Array THEN
					l_vlocarray := TREAT (l_element AS json_array_t);
					l_vlocarray.put (0, v_verloc);
					l_vlocarray.remove(1);
					l_vloc := l_vlocarray.stringify;
					
					UPDATE MOVERGEOG_JSON
					SET VERIFIED_LOC = l_vloc
					WHERE ZIPCODE = v_zip_code;
                END IF;
			ELSE
				l_element_append := JSON_ELEMENT_T.parse(l_vlappend); 

                IF l_element_append.is_Array THEN
					l_vlocarray := TREAT (l_element_append AS json_array_t);
                    l_vlocarray.append(v_verloc);
                    l_vloc := l_vlocarray.stringify;
					
					UPDATE MOVERGEOG_JSON
                    SET VERIFIED_LOC = l_vloc
                    WHERE ZIPCODE = v_zip_code;
                END IF;
			END IF;
		ELSE
			apex_util.set_session_state('P4_ERROR','Verified LOC record already exists within same Zip code');
            RAISE e_error;
		END IF;
	ELSE
		select COUNT(*) into r_cnt
        from MOVERGEOG_JSON z, 
        json_table(z.VERIFIED_LOC, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_verloc AND ZIPCODE IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')));

        IF r_cnt = 0 THEN

			FOR I IN ((SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':'))))
			LOOP
				FOR K IN (SELECT VERIFIED_LOC FROM MOVERGEOG_JSON WHERE ZIPCODE = I.COLUMN_VALUE)
				LOOP
					IF K.VERIFIED_LOC IS NULL THEN
						l_element_append := JSON_ELEMENT_T.parse('[0]'); 
						
						IF l_element_append.is_Array THEN
							l_vlocarray := TREAT (l_element_append AS json_array_t);
							l_vlocarray.put (0, v_verloc);
							l_vlocarray.remove(1);
							l_vloc := l_vlocarray.stringify;
							
							UPDATE MOVERGEOG_JSON
							SET VERIFIED_LOC = l_vloc
							WHERE ZIPCODE = I.COLUMN_VALUE;
						END IF;
					ELSE
						l_element_append := JSON_ELEMENT_T.parse(K.VERIFIED_LOC); 
						IF l_element_append.is_Array THEN
							l_vlocarray := TREAT (l_element_append AS json_array_t);
							l_vlocarray.append(v_verloc);
							l_vloc := l_vlocarray.stringify;
								
							UPDATE MOVERGEOG_JSON							
							SET VERIFIED_LOC = l_vloc
							WHERE ZIPCODE = I.COLUMN_VALUE;
						END IF;
					END IF;
				END LOOP;
			END LOOP;
		ELSE
			apex_util.set_session_state('P4_ERROR','Verified LOC already exists within one of the Zip code');
            RAISE e_error;
		END IF;
    END IF;

END add_json_vloc;

-----------------------------------------------------------------

procedure remove_json_vloc (v_verloc in varchar2, 
                            v_zip_code in varchar2, 
                            v_mul_zip in varchar2,
                            v_select_type in varchar2)
is
    l_element_append JSON_ELEMENT_T;
	l_vloc varchar2(4000);
	l_vlocarray JSON_ARRAY_T;
	ELE_INDX NUMBER;
    l_uparray varchar(4000);
    e_error exception;
    r_cnt NUMBER;
BEGIN
	IF (v_select_type = 'se') THEN
	
        SELECT VERIFIED_LOC into l_vloc
		FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code;
		
		l_element_append := JSON_ELEMENT_T.parse(l_vloc);
		
		IF l_element_append.is_Array THEN
				l_vlocarray := TREAT (l_element_append AS json_array_t);
				SELECT RN INTO ELE_INDX
				FROM
				(
					SELECT VALUE,row_number() over (order by ZIPCODE) as rn
					FROM (select value,ZIPCODE from MOVERGEOG_JSON z, 
										json_table(z.VERIFIED_LOC, '$[*]' COLUMNS (value PATH '$',rn for ordinality))) 
					WHERE ZIPCODE = v_zip_code
				)
				WHERE VALUE = v_verloc;
				l_vlocarray.remove(ELE_INDX - 1);
				l_uparray := l_vlocarray.stringify;

				UPDATE MOVERGEOG_JSON
				SET VERIFIED_LOC = l_uparray
				WHERE ZIPCODE = v_zip_code;
		END IF;
	ELSE 
		select COUNT(*) into r_cnt
        from MOVERGEOG_JSON z, 
        json_table(z.VERIFIED_LOC, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_verloc AND ZIPCODE IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')));

        IF r_cnt > 0 THEN

            FOR I IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')))
            LOOP
                FOR K IN (SELECT VERIFIED_LOC FROM MOVERGEOG_JSON WHERE ZIPCODE = I.COLUMN_VALUE)
                LOOP
                    IF K.VERIFIED_LOC IS NOT NULL THEN
						l_element_append := JSON_ELEMENT_T.parse(K.VERIFIED_LOC);
						IF l_element_append.is_Array THEN
							l_vlocarray := TREAT (l_element_append AS json_array_t);
							FOR J IN (SELECT RN
							FROM
							(
								SELECT VALUE,ZIPCODE,row_number() over (PARTITION BY ZIPCODE order by ZIPCODE) as rn
								FROM (select value,ZIPCODE from MOVERGEOG_JSON z, 
													json_table(z.VERIFIED_LOC, '$[*]' COLUMNS (value PATH '$',rn for ordinality))) 
								WHERE ZIPCODE = I.COLUMN_VALUE
							)
							WHERE VALUE = v_verloc)
							LOOP                    
								l_vlocarray.remove(J.RN - 1);
							
								l_uparray := l_vlocarray.stringify;

								UPDATE MOVERGEOG_JSON
								SET VERIFIED_LOC = l_uparray
								WHERE ZIPCODE = I.COLUMN_VALUE;
							END LOOP;
						END IF;
					END IF;
				END LOOP;
			END LOOP;
		 ELSE
            apex_util.set_session_state('P4_ERROR','Verified LOC entered doesnot exists within of the Zip Code!');
            RAISE e_error;
        END IF;
	END IF;
END remove_json_vloc;

------------------------------------------------------------------------------

procedure add_json_vinte (v_verinte in varchar2, 
                        v_zip_code in varchar2, 
                        v_mul_zip in varchar2,
                        v_select_type in varchar2)
is
	l_element JSON_ELEMENT_T;
	l_vintearray JSON_ARRAY_T;
	l_vinte varchar2(4000);
	vintcnt varchar2(255);
	l_viappend varchar2(4000);
	l_element_append JSON_ELEMENT_T;
    r_cnt number;
    e_error exception;
BEGIN
	IF (v_select_type = 'se') THEN
	
		select COUNT(*) INTO r_cnt 
        from MOVERGEOG_JSON z, 
        json_table(z.VERIFIED_INTE, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_verinte AND ZIPCODE = v_zip_code;
		
		SELECT VERIFIED_INTE into vintcnt FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code; 
        SELECT VERIFIED_INTE INTO l_viappend FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code;

		IF r_cnt = 0 THEN
			l_element := JSON_ELEMENT_T.parse('[0]');
			IF vintcnt IS NULL THEN
				IF l_element.is_Array THEN
					l_vintearray := TREAT (l_element AS json_array_t);
					l_vintearray.put (0, v_verinte);
					l_vintearray.remove(1);
					l_vinte := l_vintearray.stringify;
					
					UPDATE MOVERGEOG_JSON
					SET VERIFIED_INTE = l_vinte
					WHERE ZIPCODE = v_zip_code;
                END IF;
			ELSE
				l_element_append := JSON_ELEMENT_T.parse(l_viappend); 
                IF l_element_append.is_Array THEN
					l_vintearray := TREAT (l_element_append AS json_array_t);
                    l_vintearray.append(v_verinte);
                    l_vinte := l_vintearray.stringify;
					
					UPDATE MOVERGEOG_JSON
                    SET VERIFIED_INTE = l_vinte
                    WHERE ZIPCODE = v_zip_code;
                END IF;
			END IF;
		ELSE
			apex_util.set_session_state('P4_ERROR','Verified Inte record already exists within same Zip code');
            RAISE e_error;
		END IF;
	ELSE
		select COUNT(*) into r_cnt
        from MOVERGEOG_JSON z, 
        json_table(z.VERIFIED_INTE, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_verinte AND ZIPCODE IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')));

        IF r_cnt = 0 THEN

			FOR I IN ((SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':'))))
			LOOP
				FOR K IN (SELECT VERIFIED_INTE FROM MOVERGEOG_JSON WHERE ZIPCODE = I.COLUMN_VALUE)
				LOOP
					IF K.VERIFIED_INTE IS NULL THEN
						l_element_append := JSON_ELEMENT_T.parse('[0]'); 
						
						IF l_element_append.is_Array THEN
							l_vintearray := TREAT (l_element_append AS json_array_t);
							l_vintearray.put (0, v_verinte);
							l_vintearray.remove(1);
							l_vinte := l_vintearray.stringify;
							
							UPDATE MOVERGEOG_JSON
							SET VERIFIED_INTE = l_vinte
							WHERE ZIPCODE = I.COLUMN_VALUE;
						END IF;
					ELSE
						l_element_append := JSON_ELEMENT_T.parse(K.VERIFIED_INTE); 
						IF l_element_append.is_Array THEN
							l_vintearray := TREAT (l_element_append AS json_array_t);
							l_vintearray.append(v_verinte);
							l_vinte := l_vintearray.stringify;
							
							UPDATE MOVERGEOG_JSON
							SET VERIFIED_INTE = l_vinte
							WHERE ZIPCODE = I.COLUMN_VALUE;
						END IF;
					END IF;
				END LOOP;
			END LOOP;
		ELSE
			apex_util.set_session_state('P4_ERROR','Verified Inte already exists within one of the Zip code');
            RAISE e_error;
		END IF;
	END IF;
END add_json_vinte;

--------------------------REMOVE VERIFIED INTE---------------------------------------------------------------------------

procedure remove_json_vinte (v_verinte in varchar2, 
                            v_zip_code in varchar2, 
                            v_mul_zip in varchar2,
                            v_select_type in varchar2)
is
    l_element_append JSON_ELEMENT_T;
	l_vinte varchar2(4000);
	l_vintearray JSON_ARRAY_T;
	ELE_INDX NUMBER;
    l_uparray varchar(4000);
    e_error exception;
    r_cnt NUMBER;

BEGIN
	IF (v_select_type = 'se') THEN
	
        SELECT VERIFIED_INTE INTO l_vinte
		FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code;
		
		l_element_append := JSON_ELEMENT_T.parse(l_vinte);
			IF l_element_append.is_Array THEN
				l_vintearray := TREAT (l_element_append AS json_array_t);
				SELECT RN INTO ELE_INDX
				FROM
				(
					SELECT VALUE,row_number() over (order by ZIPCODE) as rn
					FROM (select value,ZIPCODE from MOVERGEOG_JSON z, 
										json_table(z.VERIFIED_INTE, '$[*]' COLUMNS (value PATH '$',rn for ordinality))) 
					WHERE ZIPCODE = v_zip_code
				)
				WHERE VALUE = v_verinte;
				l_vintearray.remove(ELE_INDX - 1);
				l_uparray := l_vintearray.stringify;

				UPDATE MOVERGEOG_JSON
				SET VERIFIED_INTE = l_uparray
				WHERE ZIPCODE = v_zip_code;
			END IF;
	ELSE
		select COUNT(*) into r_cnt
        from MOVERGEOG_JSON z, 
        json_table(z.VERIFIED_INTE, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_verinte AND ZIPCODE IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')));

        IF r_cnt > 0 THEN

            FOR I IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')))
            LOOP
                FOR K IN (SELECT VERIFIED_INTE FROM MOVERGEOG_JSON WHERE ZIPCODE = I.COLUMN_VALUE)
                LOOP
					IF K.VERIFIED_INTE IS NOT NULL THEN
						l_element_append := JSON_ELEMENT_T.parse(K.VERIFIED_INTE);
						IF l_element_append.is_Array THEN
							l_vintearray := TREAT (l_element_append AS json_array_t);
							FOR J IN (SELECT RN
							FROM
							(
								SELECT VALUE,ZIPCODE,row_number() over (PARTITION BY ZIPCODE order by ZIPCODE) as rn
								FROM (select value,ZIPCODE from MOVERGEOG_JSON z, 
													json_table(z.VERIFIED_INTE, '$[*]' COLUMNS (value PATH '$',rn for ordinality))) 
								WHERE ZIPCODE = I.COLUMN_VALUE
							)
							WHERE VALUE = v_verinte)
							LOOP                    
								l_vintearray.remove(J.RN - 1);
							
								l_uparray := l_vintearray.stringify;

								UPDATE MOVERGEOG_JSON
								SET VERIFIED_INTE = l_uparray
								WHERE ZIPCODE = I.COLUMN_VALUE;
							END LOOP;
						END IF;
					END IF;
				END LOOP;
			END LOOP;
		ELSE 
			apex_util.set_session_state('P4_ERROR','Verified Inte entered doesnot exists within of the Zip Code!');
            RAISE e_error;
		END IF;
	END IF;
END remove_json_vinte;

-------------------------------------------------------------------------------------------------------

procedure add_json_eloc (v_eliloc in varchar2, 
                        v_zip_code in varchar2, 
                        v_mul_zip in varchar2,
                        v_select_type in varchar2)
is
    l_element JSON_ELEMENT_T;
	l_elocarray JSON_ARRAY_T;
	l_eloc varchar2(4000);
	eloccnt varchar2(255);
	l_elappend varchar2(4000);
	l_element_append JSON_ELEMENT_T;
    r_cnt number;
    e_error exception;
BEGIN
	IF (v_select_type = 'se') THEN
	
		select COUNT(*) INTO r_cnt 
        from MOVERGEOG_JSON z, 
        json_table(z.ELITE_LOC, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_eliloc AND ZIPCODE = v_zip_code;
		
		SELECT ELITE_LOC into eloccnt FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code; 
        SELECT ELITE_LOC INTO l_elappend FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code;
		
		IF r_cnt = 0 THEN
			l_element := JSON_ELEMENT_T.parse('[0]');
			IF eloccnt IS NULL THEN
				IF l_element.is_Array THEN
					l_elocarray := TREAT (l_element AS json_array_t);
					l_elocarray.put (0, v_eliloc);
					l_elocarray.remove(1);
					l_eloc := l_elocarray.stringify;
					
					UPDATE MOVERGEOG_JSON
					SET ELITE_LOC = l_eloc
					WHERE ZIPCODE = v_zip_code;
                END IF;
			ELSE
				l_element_append := JSON_ELEMENT_T.parse(l_elappend); 

                IF l_element_append.is_Array THEN
					l_elocarray := TREAT (l_element_append AS json_array_t);
                    l_elocarray.append(v_eliloc);
                    l_eloc := l_elocarray.stringify;
					
					UPDATE MOVERGEOG_JSON
                    SET ELITE_LOC = l_eloc
                    WHERE ZIPCODE = v_zip_code;
				END IF;
			END IF;
		ELSE
			apex_util.set_session_state('P4_ERROR','Elite LOC record already exists within same Zip code');
            RAISE e_error;
		END IF;
	ELSE	
		select COUNT(*) into r_cnt
        from MOVERGEOG_JSON z, 
        json_table(z.ELITE_LOC, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_eliloc AND ZIPCODE IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')));

        IF r_cnt = 0 THEN

			FOR I IN ((SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':'))))
			LOOP
				FOR K IN (SELECT ELITE_LOC FROM MOVERGEOG_JSON WHERE ZIPCODE = I.COLUMN_VALUE)
				LOOP
					IF K.ELITE_LOC IS NULL THEN
						l_element_append := JSON_ELEMENT_T.parse('[0]');
						
						IF l_element_append.is_Array THEN
							l_elocarray := TREAT (l_element_append AS json_array_t);
							l_elocarray.put (0, v_eliloc);
							l_elocarray.remove(1);
							l_eloc := l_elocarray.stringify;
							
							UPDATE MOVERGEOG_JSON
							SET ELITE_LOC = l_eloc
							WHERE ZIPCODE = I.COLUMN_VALUE;
						END IF;
					ELSE
						l_element_append := JSON_ELEMENT_T.parse(K.ELITE_LOC); 

						IF l_element_append.is_Array THEN
							l_elocarray := TREAT (l_element_append AS json_array_t);
							l_elocarray.append(v_eliloc);
							l_eloc := l_elocarray.stringify;
							
							UPDATE MOVERGEOG_JSON
							SET ELITE_LOC = l_eloc
							WHERE ZIPCODE = I.COLUMN_VALUE;
						END IF;
					END IF;
				END LOOP;
			END LOOP;
		ELSE
			apex_util.set_session_state('P4_ERROR','Elite LOC already exists within one of the Zip code');
            RAISE e_error;
		END IF;
	END IF;
END add_json_eloc;

-------------------------------------------REMOVE ELITE LOC---------------------------------------------------------

procedure remove_json_eloc (v_eliloc in varchar2, 
                            v_zip_code in varchar2, 
                            v_mul_zip in varchar2,
                            v_select_type in varchar2)
is
    l_element_append JSON_ELEMENT_T;
	l_eloc varchar2(4000);
	l_elocarray JSON_ARRAY_T;
	ELE_INDX NUMBER;
    l_uparray varchar(4000);
    e_error exception;
    r_cnt NUMBER;
BEGIN
	IF (v_select_type = 'se') THEN
	
        SELECT ELITE_LOC INTO l_eloc
		FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code;
		
		l_element_append := JSON_ELEMENT_T.parse(l_eloc);
			IF l_element_append.is_Array THEN
				l_elocarray := TREAT (l_element_append AS json_array_t);
				SELECT RN INTO ELE_INDX
				FROM
				(
					SELECT VALUE,row_number() over (order by ZIPCODE) as rn
					FROM (select value,ZIPCODE from MOVERGEOG_JSON z, 
										json_table(z.ELITE_LOC, '$[*]' COLUMNS (value PATH '$',rn for ordinality))) 
					WHERE ZIPCODE = v_zip_code
				)
				WHERE VALUE = v_eliloc;
				l_elocarray.remove(ELE_INDX - 1);
				l_uparray := l_elocarray.stringify;

				UPDATE MOVERGEOG_JSON
				SET ELITE_LOC = l_uparray
				WHERE ZIPCODE = v_zip_code;
			END IF;
	ELSE
		select COUNT(*) into r_cnt
        from MOVERGEOG_JSON z, 
        json_table(z.ELITE_LOC, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_eliloc AND ZIPCODE IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')));

        IF r_cnt > 0 THEN

            FOR I IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')))
            LOOP
                FOR K IN (SELECT ELITE_LOC FROM MOVERGEOG_JSON WHERE ZIPCODE = I.COLUMN_VALUE)
                LOOP
					IF K.ELITE_LOC IS NOT NULL THEN
						l_element_append := JSON_ELEMENT_T.parse(K.ELITE_LOC);
						IF l_element_append.is_Array THEN
							l_elocarray := TREAT (l_element_append AS json_array_t);
							FOR J IN (SELECT RN
							FROM
							(
								SELECT VALUE,ZIPCODE,row_number() over (PARTITION BY ZIPCODE order by ZIPCODE) as rn
								FROM (select value,ZIPCODE from MOVERGEOG_JSON z, 
													json_table(z.ELITE_LOC, '$[*]' COLUMNS (value PATH '$',rn for ordinality))) 
								WHERE ZIPCODE = I.COLUMN_VALUE
							)
							WHERE VALUE = v_eliloc)
							LOOP                    
								l_elocarray.remove(J.RN - 1);
							
								l_uparray := l_elocarray.stringify;

								UPDATE MOVERGEOG_JSON
								SET ELITE_LOC = l_uparray
								WHERE ZIPCODE = I.COLUMN_VALUE;
							END LOOP;
						END IF;
					END IF;
				END LOOP;
			END LOOP;
		ELSE
			apex_util.set_session_state('P4_ERROR','Elite LOC entered doesnot exists within of the Zip Code!');
            RAISE e_error;
		END IF;
	END IF;
		
END remove_json_eloc;

------------------------------------------------------------------------------------------

procedure add_json_einte (v_elinte in varchar2, 
                        v_zip_code in varchar2, 
                        v_mul_zip in varchar2,
                        v_select_type in varchar2)
is
    l_element JSON_ELEMENT_T;
	l_eintearray JSON_ARRAY_T;
	l_einte varchar2(4000);
	eintecnt varchar2(255);
	l_eiappend varchar2(4000);
    l_element_append JSON_ELEMENT_T;
    r_cnt number;
    e_error exception;
BEGIN
	IF (v_select_type = 'se') THEN
	
		select COUNT(*) INTO r_cnt 
        from MOVERGEOG_JSON z, 
        json_table(z.ELITE_INTE, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_elinte AND ZIPCODE = v_zip_code;
		
		SELECT ELITE_INTE into eintecnt FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code; 
        SELECT ELITE_INTE INTO l_eiappend FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code;
		
		IF r_cnt = 0 THEN
			l_element := JSON_ELEMENT_T.parse('[0]');
			IF eintecnt IS NULL THEN
				IF l_element.is_Array THEN
					l_eintearray := TREAT (l_element AS json_array_t);
					l_eintearray.put (0, v_elinte);
					l_eintearray.remove(1);
					l_einte := l_eintearray.stringify;
					
					UPDATE MOVERGEOG_JSON
					SET ELITE_INTE = l_einte
					WHERE ZIPCODE = v_zip_code;
                END IF;
			ELSE
				l_element_append := JSON_ELEMENT_T.parse(l_eiappend); 

                IF l_element_append.is_Array THEN
					l_eintearray := TREAT (l_element_append AS json_array_t);
                    l_eintearray.append(v_elinte);
                    l_einte := l_eintearray.stringify;
					
					UPDATE MOVERGEOG_JSON
                    SET ELITE_INTE = l_einte
                    WHERE ZIPCODE = v_zip_code;
				END IF;
			END IF;
        ELSE 
            apex_util.set_session_state('P4_ERROR','Elite Inte already exists within same Zip code');
            RAISE e_error;
        END IF;
	ELSE
		select COUNT(*) into r_cnt
        from MOVERGEOG_JSON z, 
        json_table(z.ELITE_INTE, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_elinte AND ZIPCODE IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')));

        IF r_cnt = 0 THEN

			FOR I IN ((SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':'))))
			LOOP
				FOR K IN (SELECT ELITE_INTE FROM MOVERGEOG_JSON WHERE ZIPCODE = I.COLUMN_VALUE)
				LOOP
					IF K.ELITE_INTE IS NULL THEN
					l_element_append := JSON_ELEMENT_T.parse('[0]');
					
						IF l_element_append.is_Array THEN
							l_eintearray := TREAT (l_element_append AS json_array_t);
							l_eintearray.put (0, v_elinte);
							l_eintearray.remove(1);
							l_einte := l_eintearray.stringify;
							
							UPDATE MOVERGEOG_JSON
							SET ELITE_INTE = l_einte
							WHERE ZIPCODE = I.COLUMN_VALUE;
						END IF;
					ELSE
						l_element_append := JSON_ELEMENT_T.parse(K.ELITE_INTE); 

						IF l_element_append.is_Array THEN
							l_eintearray := TREAT (l_element_append AS json_array_t);
							l_eintearray.append(v_elinte);
							l_einte := l_eintearray.stringify;
							
							UPDATE MOVERGEOG_JSON
							SET ELITE_INTE = l_einte
							WHERE ZIPCODE = I.COLUMN_VALUE;
						END IF;
					END IF;
				END LOOP;
			END LOOP;
		ELSE
			apex_util.set_session_state('P4_ERROR','Elite Inte already exists within one of the Zip code');
            RAISE e_error;
		END IF;
	END IF;
END add_json_einte;

------------------------------REMOVE ELITE INTE--------------------------------------------------

procedure remove_json_einte (v_elinte in varchar2, 
                            v_zip_code in varchar2, 
                            v_mul_zip in varchar2,
                            v_select_type in varchar2)
is
    l_element_append JSON_ELEMENT_T;
	l_einte varchar2(4000);    
	l_eintearray JSON_ARRAY_T;
    ELE_INDX NUMBER;
    l_uparray varchar(4000);
    e_error exception;
    r_cnt NUMBER;
BEGIN
	IF (v_select_type = 'se') THEN
	
        SELECT ELITE_INTE INTO l_einte
		FROM MOVERGEOG_JSON WHERE ZIPCODE = v_zip_code;
		
		l_element_append := JSON_ELEMENT_T.parse(l_einte);
			IF l_element_append.is_Array THEN
				l_eintearray := TREAT (l_element_append AS json_array_t);
				SELECT RN INTO ELE_INDX
				FROM
				(
					SELECT VALUE,row_number() over (order by ZIPCODE) as rn
					FROM (select value,ZIPCODE from MOVERGEOG_JSON z, 
										json_table(z.ELITE_INTE, '$[*]' COLUMNS (value PATH '$',rn for ordinality))) 
					WHERE ZIPCODE = v_zip_code
				)
				WHERE VALUE = v_elinte;
				l_eintearray.remove(ELE_INDX - 1);
				l_uparray := l_eintearray.stringify;

				UPDATE MOVERGEOG_JSON
				SET ELITE_INTE = l_uparray
				WHERE ZIPCODE = v_zip_code;
			END IF;
	ELSE
		select COUNT(*) into r_cnt
        from MOVERGEOG_JSON z, 
        json_table(z.ELITE_INTE, '$[*]' COLUMNS (value PATH '$')) 
        WHERE VALUE = v_elinte AND ZIPCODE IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')));

        IF r_cnt > 0 THEN

            FOR I IN (SELECT * FROM table (apex_string.split_numbers(v_mul_zip,':')))
            LOOP
                FOR K IN (SELECT ELITE_INTE FROM MOVERGEOG_JSON WHERE ZIPCODE = I.COLUMN_VALUE)
                LOOP
					IF K.ELITE_INTE IS NOT NULL THEN
						l_element_append := JSON_ELEMENT_T.parse(K.ELITE_INTE);
						IF l_element_append.is_Array THEN
							l_eintearray := TREAT (l_element_append AS json_array_t);
							FOR J IN (SELECT RN
							FROM
							(
								SELECT VALUE,ZIPCODE,row_number() over (PARTITION BY ZIPCODE order by ZIPCODE) as rn
								FROM (select value,ZIPCODE from MOVERGEOG_JSON z, 
													json_table(z.ELITE_INTE, '$[*]' COLUMNS (value PATH '$',rn for ordinality))) 
								WHERE ZIPCODE = I.COLUMN_VALUE
							)
							WHERE VALUE = v_elinte)
							LOOP                    
								l_eintearray.remove(J.RN - 1);
							
								l_uparray := l_eintearray.stringify;

								UPDATE MOVERGEOG_JSON
								SET ELITE_INTE = l_uparray
								WHERE ZIPCODE = I.COLUMN_VALUE;
							END LOOP;
						END IF;
					END IF;
				END LOOP;
			END LOOP;
		ELSE
			apex_util.set_session_state('P4_ERROR','Elite Inte entered doesnot exists within of the Zip Code!');
            RAISE e_error;
		END IF;
	END IF;
		
END remove_json_einte;

END JSON_ADD_REMOVE;

/
