--------------------------------------------------------
--  Ref Constraints for Table LOGGER_LOGS_APEX_ITEMS
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."LOGGER_LOGS_APEX_ITEMS" ADD CONSTRAINT "LOGGER_LOGS_APX_ITMS_FK" FOREIGN KEY ("LOG_ID")
	  REFERENCES "INSTITUTE"."LOGGER_LOGS" ("ID") ON DELETE CASCADE ENABLE;
