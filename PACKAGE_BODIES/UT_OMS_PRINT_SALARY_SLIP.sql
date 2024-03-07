--------------------------------------------------------
--  DDL for Package Body UT_OMS_PRINT_SALARY_SLIP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."UT_OMS_PRINT_SALARY_SLIP" is

   -- generated by utPLSQL for SQL Developer on 2023-04-28 16:51:28

   --
   -- test print_salslip
   --
procedure print_salslip is
      c_actual SYS_REFCURSOR;
      c_expected SYS_REFCURSOR;
begin
      -- arrange

      -- act
      -- oms_print_salary_slip.print_salslip;
    open c_actual for
        SELECT SAL_ID, COMP_ID, FIN_ID 
        FROM OMS_EMP_MONTHLY_SAL_DET
        WHERE SAL_ID = 1;
    
    open c_expected for
        SELECT 1 AS SAL_ID, 
            1 AS COMP_ID, 
            62 AS FIN_ID 
        FROM DUAL;
        
      -- assert
    ut.expect(c_actual).to_equal(c_expected);
end print_salslip;

end UT_OMS_PRINT_SALARY_SLIP;

/
