--------------------------------------------------------
--  DDL for Package Body OAC_AWS_S3_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."OAC_AWS_S3_UTIL" AS

FUNCTION get_presigned_url(p_file_name IN varchar2, p_mime_type IN VARCHAR2) return varchar2
IS 
    l_rest_url VARCHAR2(2000) := 'https://ofumf2srpb.execute-api.ap-south-1.amazonaws.com/default/my-oaclambda-function';
    l_signed_url CLOB;
    l_request_body CLOB;
BEGIN
    -- Pass the request headers with POST request to URL--
    apex_web_service.g_request_headers(1).name  := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';

    --Pass the filename and type in order to store with same filename as passed in Bucket--
    l_request_body := '{
        "fileName" : "'||p_file_name||'",
        "fileType" : "'||p_mime_type||'"
    }';

    --Make a POST request to URL by passing file info in Body--
    l_signed_url := apex_web_service.make_rest_request(
        p_url         => l_rest_url,
        p_http_method => 'POST',
        p_body        => l_request_body);

    dbms_output.put_line ('Status Code : '||apex_web_service.g_status_code);

    --Extract the URL from above response
    APEX_JSON.PARSE(l_signed_url);
    l_signed_url := APEX_JSON.GET_VARCHAR2(p_path => 'uploadURL');
    dbms_output.put_line ('URL : '||l_signed_url);

    RETURN l_signed_url;

EXCEPTION
    WHEN OTHERS THEN 
        apex_error.add_error (
     	p_message          => 'Error during obtaining Presigned URL',
    	p_display_location =>  apex_error.c_inline_in_notification);
        
END get_presigned_url;

procedure upload_file_to_aws (p_upload_file in varchar2, p_response out varchar2)
IS
    l_signed_url VARCHAR2(32767);
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

    l_signed_url := OAC_AWS_S3_UTIL.get_presigned_url(l_filename, l_mime_type);

    --Check whether l_signed_url is null or not, if not so then follow below process--
    IF(l_signed_url IS NOT NULL) THEN
    
        --Pass request headers with content type of uploaded file--
        apex_web_service.g_request_headers(1).name  := 'Content-Type';
        apex_web_service.g_request_headers(1).value := l_mime_type;
    
        -- PUT file in S3 bucket using the pre-signed URL--
        l_response_clob := apex_web_service.make_rest_request(
            p_url         => l_signed_url,
            p_http_method => 'PUT',
            p_body_blob   => l_file);

        dbms_output.put_line ('Code : '||apex_web_service.g_status_code);
        dbms_output.put_line ('Body : '||l_response_clob);
    END IF;

EXCEPTION WHEN OTHERS THEN 
    p_response := 'Error while Uploading File to AWS S3 Bucket';

END upload_file_to_aws;

END OAC_AWS_S3_UTIL;

/
