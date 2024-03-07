--------------------------------------------------------
--  DDL for Package JSON_ADD_REMOVE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."JSON_ADD_REMOVE" as

procedure add_json_mover (
   v_mover_id in varchar2,
   v_zip_code in varchar2 default null,
   v_mul_zip in varchar2 default null,
   v_select_type in varchar2 default null);

procedure remove_json_mover (
   v_mover_id in varchar2 default null,
   v_zip_code in varchar2 default null,
   v_mul_zip in varchar2 default null,
   v_select_type in varchar2 default null);

procedure add_json_vloc (
   v_verloc in varchar2,
   v_zip_code in varchar2 default null,
   v_mul_zip in varchar2 default null,
   v_select_type in varchar2 default null);

procedure remove_json_vloc (
   v_verloc in varchar2 default null,
   v_zip_code in varchar2 default null,
   v_mul_zip in varchar2 default null,
   v_select_type in varchar2 default null);

procedure add_json_vinte (
    v_verinte in varchar2, 
    v_zip_code in varchar2, 
    v_mul_zip in varchar2,
    v_select_type in varchar2);

procedure remove_json_vinte (
    v_verinte in varchar2, 
    v_zip_code in varchar2, 
    v_mul_zip in varchar2,
    v_select_type in varchar2);

procedure add_json_eloc (
    v_eliloc in varchar2, 
    v_zip_code in varchar2, 
    v_mul_zip in varchar2,
    v_select_type in varchar2);

procedure remove_json_eloc (
    v_eliloc in varchar2, 
    v_zip_code in varchar2, 
    v_mul_zip in varchar2,
    v_select_type in varchar2);

procedure add_json_einte (
    v_elinte in varchar2, 
    v_zip_code in varchar2,
    v_mul_zip in varchar2,
    v_select_type in varchar2);

procedure remove_json_einte (
    v_elinte in varchar2, 
    v_zip_code in varchar2,
    v_mul_zip in varchar2,
    v_select_type in varchar2);

end;

/
