--------------------------------------------------------
--  DDL for Procedure SEND_MAIL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INSTITUTE"."SEND_MAIL" ( 
  p_mail_host  in  varchar2, 
  p_from       in  varchar2, 
  p_to         in  varchar2, 
  p_subject    in  varchar2, 
  p_message    in  varchar2) 
as 
   l_mail_conn   utl_smtp.connection; 
begin 
  l_mail_conn := utl_smtp.open_connection(p_mail_host, 25); 
  utl_smtp.helo(l_mail_conn, p_mail_host); 
  utl_smtp.mail(l_mail_conn, p_from); 
  utl_smtp.rcpt(l_mail_conn, p_to); 
 
  utl_smtp.open_data(l_mail_conn); 
 
  utl_smtp.write_data(l_mail_conn, 'Date: ' || to_char(sysdate, 'DD-MON-YYYY HH24:MI:SS') || Chr(13)); 
  utl_smtp.write_data(l_mail_conn, 'From: ' || p_from || Chr(13)); 
  utl_smtp.write_data(l_mail_conn, 'Subject: ' || p_subject || Chr(13)); 
  utl_smtp.write_data(l_mail_conn, 'To: ' || p_to || Chr(13)); 
  utl_smtp.write_data(l_mail_conn, '' || Chr(13)); 
  utl_smtp.write_data(l_mail_conn, p_message || Chr(13)); 
 
  utl_smtp.close_data(l_mail_conn); 
  utl_smtp.quit(l_mail_conn); 
end  send_mail; 

/
