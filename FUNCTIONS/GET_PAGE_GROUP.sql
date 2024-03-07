--------------------------------------------------------
--  DDL for Function GET_PAGE_GROUP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "INSTITUTE"."GET_PAGE_GROUP" (
    p_app_id   IN  NUMBER,
    p_page_id  IN  NUMBER
) RETURN VARCHAR2 IS
BEGIN
    FOR i IN (
        SELECT
            page_group
        FROM
            apex_application_pages
        WHERE
                application_id = p_app_id
            AND page_id = p_page_id
    ) LOOP
        RETURN i.page_group;
    END LOOP;

    RETURN NULL;
END get_page_group;

/
