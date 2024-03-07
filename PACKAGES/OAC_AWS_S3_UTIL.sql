--------------------------------------------------------
--  DDL for Package OAC_AWS_S3_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."OAC_AWS_S3_UTIL" AS

function get_presigned_url(
    p_file_name IN varchar2, 
    p_mime_type IN VARCHAR2) 
return varchar2;

procedure upload_file_to_aws (
    p_upload_file in varchar2, 
    p_response out varchar2);
    
END OAC_AWS_S3_UTIL;

/
