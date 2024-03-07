--------------------------------------------------------
--  DDL for Package Body UT_OMS_LEAVE_UTL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "INSTITUTE"."UT_OMS_LEAVE_UTL" is

   -- generated by utPLSQL for SQL Developer on 2023-04-28 15:20:27

   --
   -- test process_paid_leave
   --
procedure process_paid_leave is
    c_actual sys_refcursor;
    c_expected sys_refcursor;
begin
      -- arrange

      -- act
      -- oms_leave_utl.process_paid_leave;
       -- assert
    open c_actual for
        SELECT LEAVE_ID, COMP_ID, FIN_ID
        FROM OMS_EMP_LEAVE_DETAILS
        WHERE EMPLOYEE_ID = 31;
    
    open c_expected for
        SELECT 202 AS LEAVE_ID, 
            1 AS COMP_ID,
            62 AS FIN_ID
        FROM DUAL;
     
    ut.expect(c_actual).to_equal(c_expected);
end process_paid_leave;

   --
   -- test process_unpaid_leave
   --
procedure process_unpaid_leave is
    c_actual sys_refcursor;
    c_expected sys_refcursor;
begin
      -- arrange

      -- act
      -- oms_leave_utl.process_unpaid_leave;
    open c_actual for
        SELECT LEAVE_ID, COMP_ID, FIN_ID
        FROM OMS_EMP_LEAVE_DETAILS
        WHERE EMPLOYEE_ID = 31;
    
    open c_expected for
        SELECT 202 AS LEAVE_ID, 
            1 AS COMP_ID,
            62 AS FIN_ID
        FROM DUAL;
    
      -- assert
      ut.expect(c_actual).to_equal(c_expected);
end process_unpaid_leave;

   --
   -- test manage_half_leave
   --
procedure manage_half_leave is
    c_actual sys_refcursor;
    c_expected sys_refcursor;
begin
      -- arrange
    
      -- act
      -- oms_leave_utl.manage_half_leave;
    open c_actual for
        SELECT LEAVE_ID, APPROVED_BY, COMP_ID, FIN_ID
        FROM OMS_EMP_LEAVE_DETAILS
        WHERE EMPLOYEE_ID = 31;
    
    open c_expected for
        SELECT 202 AS LEAVE_ID,
            'ADMIN' AS APPROVED_BY,
            1 AS COMP_ID,
            62 AS FIN_ID
        FROM DUAL;
        
      -- assert
    ut.expect(c_actual).to_equal(c_expected);
end manage_half_leave;

end UT_OMS_LEAVE_UTL;

/
