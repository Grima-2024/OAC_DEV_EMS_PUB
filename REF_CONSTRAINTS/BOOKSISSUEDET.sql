--------------------------------------------------------
--  Ref Constraints for Table BOOKSISSUEDET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."BOOKSISSUEDET" ADD CONSTRAINT "BOOKSISSUEDET_BOOKSLISTDET_FK" FOREIGN KEY ("BOOKID")
	  REFERENCES "INSTITUTE"."BOOKSLISTDET" ("BOOKID") ENABLE;
