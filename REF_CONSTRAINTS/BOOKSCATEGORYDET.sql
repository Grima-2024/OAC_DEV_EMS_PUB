--------------------------------------------------------
--  Ref Constraints for Table BOOKSCATEGORYDET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."BOOKSCATEGORYDET" ADD CONSTRAINT "BOOKSCATDET_LIBRARY_MST_FK" FOREIGN KEY ("LIB_ID")
	  REFERENCES "INSTITUTE"."LIBRARY_MST" ("LIB_ID") ENABLE;
