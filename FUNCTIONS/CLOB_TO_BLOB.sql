--------------------------------------------------------
--  DDL for Function CLOB_TO_BLOB
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "INSTITUTE"."CLOB_TO_BLOB" (p_data  IN  CLOB)
	RETURN BLOB
AS
	l_blob         BLOB;
	l_dest_offset  PLS_INTEGER := 1;
	l_src_offset   PLS_INTEGER := 1;
	l_lang_context PLS_INTEGER := DBMS_LOB.default_lang_ctx;
	l_warning      PLS_INTEGER := DBMS_LOB.warn_inconvertible_char;
BEGIN

  	DBMS_LOB.createtemporary(
	    lob_loc => l_blob,
	    cache   => TRUE);

  	DBMS_LOB.converttoblob(
	   dest_lob      => l_blob,
	   src_clob      => p_data,
	   amount        => DBMS_LOB.lobmaxsize,
	   dest_offset   => l_dest_offset,
	   src_offset    => l_src_offset, 
	   blob_csid     => DBMS_LOB.default_csid,
	   lang_context  => l_lang_context,
	   warning       => l_warning);

   RETURN l_blob;
END;

/
