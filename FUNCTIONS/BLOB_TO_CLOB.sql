--------------------------------------------------------
--  DDL for Function BLOB_TO_CLOB
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "INSTITUTE"."BLOB_TO_CLOB" (blob_in IN BLOB)
RETURN CLOB
AS
    v_clob CLOB;
    v_varchar VARCHAR2(32767);
    v_start pls_integer  := 1;
    v_buffer pls_integer := 32767;
BEGIN
    dbms_lob.createtemporary(v_clob, TRUE);
    
    FOR i IN 1..ceil(dbms_lob.getlength(blob_in) / v_buffer)
    loop
        v_varchar := utl_raw.cast_to_varchar2(dbms_lob.substr(blob_in, v_buffer, v_start));
        dbms_lob.writeappend(v_clob, LENGTH(v_varchar), v_varchar);
        v_start := v_start + v_buffer;
    END loop;

    RETURN v_clob;

END blob_to_clob;

/
