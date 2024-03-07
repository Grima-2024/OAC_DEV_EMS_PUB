--------------------------------------------------------
--  DDL for Function HASH_PASSWORD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "INSTITUTE"."HASH_PASSWORD" (p_user_name in varchar2, p_password  in varchar2)
return varchar2
is
    l_password varchar2(255);
    l_salt  varchar2(255) := '2345USFGOJN2T3HW89EFGOBN23R5SDFGAKL'; -- Should be changed to another random string.
begin
    l_password := utl_raw.cast_to_raw (
					dbms_obfuscation_toolkit.md5(
					  input_string => p_password ||
                                      substr(l_salt,4,14) ||
                                      p_user_name ||
                                      substr(l_salt,5,10)));
    return l_password;
end hash_password;

/
