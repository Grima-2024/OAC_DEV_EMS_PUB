--------------------------------------------------------
--  Ref Constraints for Table BOOKSLISTDET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."BOOKSLISTDET" ADD CONSTRAINT "BOOKSLISTDET_BOOKSCATDET_FK" FOREIGN KEY ("BOOKCAT_ID")
	  REFERENCES "INSTITUTE"."BOOKSCATEGORYDET" ("BOOKCAT_ID") ENABLE;
