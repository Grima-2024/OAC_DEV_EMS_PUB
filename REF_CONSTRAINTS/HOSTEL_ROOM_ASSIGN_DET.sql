--------------------------------------------------------
--  Ref Constraints for Table HOSTEL_ROOM_ASSIGN_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."HOSTEL_ROOM_ASSIGN_DET" ADD CONSTRAINT "HSTL_RM_ASN_DET_HSTL_RM_MST_FK" FOREIGN KEY ("ROOM_ID")
	  REFERENCES "INSTITUTE"."HOSTEL_ROOM_MST" ("ROOM_ID") ENABLE;
