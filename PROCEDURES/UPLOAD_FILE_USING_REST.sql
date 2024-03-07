--------------------------------------------------------
--  DDL for Procedure UPLOAD_FILE_USING_REST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INSTITUTE"."UPLOAD_FILE_USING_REST" (p_upload_file IN VARCHAR2)
IS
    l_rest_url VARCHAR2(2000) := 'https://ou7w0oan3zmrham-dboacdev2021.adb.ap-mumbai-1.oraclecloudapps.com/ords/ems/hr/uploadfile/';
    l_file BLOB;
    l_mime_type VARCHAR2(100);
    l_filename VARCHAR2(100);
    l_response_clob CLOB;
BEGIN
    -- Get a File Blob Content
    SELECT MIME_TYPE, BLOB_CONTENT, FILENAME 
    INTO l_mime_type, l_file, l_filename
    FROM APEX_APPLICATION_TEMP_FILES 
    WHERE NAME = p_upload_file;

    --Pass request headers with content type of uploaded file--
    apex_web_service.g_request_headers(1).name  := 'Content-Type';
    apex_web_service.g_request_headers(1).value := l_mime_type;
    apex_web_service.g_request_headers(2).name  := 'FILENAME';
    apex_web_service.g_request_headers(2).value := l_filename;
    apex_web_service.g_request_headers(3).name  := 'MIME_TYPE';
    apex_web_service.g_request_headers(3).value := l_mime_type;

    --Pass the BLOB content to blob body in POST request..
    l_response_clob := apex_web_service.make_rest_request(
        p_url         => l_rest_url,
        p_http_method => 'POST',
        p_username    => 'INSTITUTE',
        p_password    => 'OAConsultant@2022',
        p_body_blob   => l_file);

    /*dbms_output.put_line ('Code : '||apex_web_service.g_status_code);
    dbms_output.put_line ('Body : '||l_response_clob);*/

END upload_file_using_rest;

/
