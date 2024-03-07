--------------------------------------------------------
--  Ref Constraints for Table LIBFINEDET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."LIBFINEDET" ADD CONSTRAINT "LIBFINEDET_BOOKSISSUEDET_FK" FOREIGN KEY ("BOOKISSUEID")
	  REFERENCES "INSTITUTE"."BOOKSISSUEDET" ("BOOKISSUEID") ENABLE;
