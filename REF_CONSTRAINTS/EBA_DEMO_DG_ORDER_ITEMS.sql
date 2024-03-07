--------------------------------------------------------
--  Ref Constraints for Table EBA_DEMO_DG_ORDER_ITEMS
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EBA_DEMO_DG_ORDER_ITEMS" ADD CONSTRAINT "EBA_DEMO_DG_OI_ORDER_ID_FK" FOREIGN KEY ("ORDER_ID")
	  REFERENCES "INSTITUTE"."EBA_DEMO_DG_ORDERS" ("ORDER_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "INSTITUTE"."EBA_DEMO_DG_ORDER_ITEMS" ADD CONSTRAINT "EBA_DEMO_DG_OI_PROD_ID_FK" FOREIGN KEY ("PRODUCT_ID")
	  REFERENCES "INSTITUTE"."EBA_DEMO_DG_PRODUCTS" ("PRODUCT_ID") ON DELETE CASCADE ENABLE;
