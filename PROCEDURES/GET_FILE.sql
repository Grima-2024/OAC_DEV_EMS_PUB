--------------------------------------------------------
--  DDL for Procedure GET_FILE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INSTITUTE"."GET_FILE" (p_file_name  IN VARCHAR2) 
IS
    l_blob_content  BLOB;
    l_mime_type     VARCHAR2(3000);
BEGIN
    SELECT blob_content INTO l_blob_content FROM APEX_APPLICATION_FILES WHERE FILENAME = p_file_name;
    
    sys.HTP.init;
    sys.OWA_UTIL.mime_header(l_mime_type, FALSE);
    sys.HTP.p('Content-Length: ' || DBMS_LOB.getlength(l_blob_content));
    sys.HTP.p('Content-Disposition: filename="' || p_file_name || '"');
    sys.OWA_UTIL.http_header_close;

    sys.WPG_DOCLOAD.download_file(l_blob_content);
    apex_application.stop_apex_engine;

EXCEPTION
    WHEN apex_application.e_stop_apex_engine THEN
        NULL;
    WHEN OTHERS THEN
        HTP.p('Whoops');
END;

/
