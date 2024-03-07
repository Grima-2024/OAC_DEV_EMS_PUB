--------------------------------------------------------
--  DDL for Package EMS_NEW_DOWNLOAD_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."EMS_NEW_DOWNLOAD_PKG" as

---------------------------------------------------------------------------------------------------------------------- 
-----------=============This package contains code for PDF printing of result and fees receipt==============----------
---------------------------------------------------------------------------------------------------------------------- 

procedure fees_receipt (
   p_stud_id in number default null,
   p_fees_id in number default null,
   p_inst in number   default null,
   p_acyr_id in number default null);

procedure result_printing (
   p_test_id in number default null,
   p_std_id in number  default null,
   p_inst in number default null,
   p_acyr_id in number default null);

procedure print_report_card (
   p_stud_id in number default null,
   p_inst in number default null,
   p_acyr_id in number default null);

end EMS_NEW_DOWNLOAD_PKG;

/
