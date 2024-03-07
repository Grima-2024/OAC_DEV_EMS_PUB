--------------------------------------------------------
--  DDL for Package Body EMS_ENC_DEC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."EMS_ENC_DEC" AS

    g_key     RAW(32767)  := UTL_RAW.cast_to_raw('1a2b3c4d');
    g_pad_chr VARCHAR2(1) := '~';

---------------------ENCRYPTION------------------------------- 
FUNCTION encrypt (p_text  IN  VARCHAR2) RETURN RAW 
IS
    l_text       VARCHAR2(32767) := p_text;
    l_encrypted  RAW(32767);
BEGIN
    padstring(l_text);

    DBMS_OBFUSCATION_TOOLKIT.desencrypt(
        input  => UTL_RAW.cast_to_raw(l_text),
        key    => g_key,
        encrypted_data => l_encrypted);

    RETURN l_encrypted;
END encrypt;
  
---------------------DECRYPTION------------------------------- 
FUNCTION decrypt (p_raw  IN  RAW) RETURN VARCHAR2 
IS
    l_decrypted  VARCHAR2(32767);
BEGIN
    DBMS_OBFUSCATION_TOOLKIT.desdecrypt(
        input => p_raw,
        key   => g_key,
        decrypted_data => l_decrypted);
                                            
        RETURN RTrim(UTL_RAW.cast_to_varchar2(l_decrypted), g_pad_chr);
END decrypt;

----------------------PADSTRING------------------------------ 
PROCEDURE padstring (p_text  IN OUT  VARCHAR2) 
IS
    l_units  NUMBER;
BEGIN
    IF LENGTH(p_text) MOD 8 > 0 THEN
        l_units := TRUNC(LENGTH(p_text)/8) + 1;
        p_text  := RPAD(p_text, l_units * 8, g_pad_chr);
    END IF;
END padstring;
    
END EMS_ENC_DEC;

/
