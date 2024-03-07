--------------------------------------------------------
--  Ref Constraints for Table HOSTEL_ROOM_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."HOSTEL_ROOM_MST" ADD CONSTRAINT "HOSTEL_ROOM_MST_HOSTEL_MST_FK" FOREIGN KEY ("HOSTEL_ID")
	  REFERENCES "INSTITUTE"."HOSTEL_MST" ("HOSTEL_ID") ENABLE;
