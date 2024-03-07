--------------------------------------------------------
--  Ref Constraints for Table EBA_DEMO_DG_ORDERS
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EBA_DEMO_DG_ORDERS" ADD CONSTRAINT "EBA_DEMO_DG_ORD_CUST_ID_FK" FOREIGN KEY ("CUSTOMER_ID")
	  REFERENCES "INSTITUTE"."EBA_DEMO_DG_CUSTOMERS" ("CUSTOMER_ID") ON DELETE CASCADE ENABLE;
