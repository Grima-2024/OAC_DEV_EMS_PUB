--------------------------------------------------------
--  DDL for Package DOWNLOAD_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "INSTITUTE"."DOWNLOAD_PKG" as

procedure fees_receipt (
   p_stud_id in number default null,
   p_fees_id in number default null,
   p_inst in number   default null);

procedure fees_invoice (
   p_stud_id in number default null,
   p_inst in number   default null);

procedure result_print (
   p_test_id in number default null,
   p_std_id in number  default null,
   p_inst in number default null);

procedure print_report_card (
   p_stud_id in number default null,
   p_inst in number default null);

procedure invoice_receipt(
    p_comp in varchar2 default null,
    p_street in varchar2 default null,
    p_addr in varchar2 default null,
    p_telno in varchar2 default null,
    p_country in varchar2 default null,
    p_vat_no in varchar2 default null,
    p_comp_reg_no in varchar2 default null,
    p_invoice_attn in varchar2 default null,
    p_invoice_nm in varchar2 default null,
    p_invoice_mail in varchar2 default null,
    p_invoice_no in number default null,
    p_date in date default null,
    p_due_date in date default null,
    p_test_plan in varchar2 default null,
    p_rate in varchar2 default null,
    p_tax in varchar2 default null,
    p_total_due in varchar2 default null);

end;

/
