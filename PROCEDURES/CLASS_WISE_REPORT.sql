--------------------------------------------------------
--  DDL for Procedure CLASS_WISE_REPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INSTITUTE"."CLASS_WISE_REPORT" (
    P3031_START_DATE IN date,
    P3031_END_DATE IN date,
    P3031_MED_ID_1 IN number,
    P3031_STD_ID_1 IN number,
    P3031_DIV_ID_1 IN number,
    P0_INSTITUTE IN number,
    APP_ACADEMIC IN number
    )
IS
    sqlqry clob;
    date_cols clob;
    show_dt_cols clob;
begin
    select listagg(''''||ATTEND_DT||''' as "'||ATTEND_DT||'"', ', ') within group (order by ATTEND_DT)
    into date_cols
    from 
    (
        select distinct ATTEND_DT
        FROM AT_STUD_ATTENDANCE
        WHERE ATTEND_DT BETWEEN P3031_START_DATE and P3031_END_DATE
    );

    select listagg('"'||ATTEND_DT||'"', ', ') within group (order by ATTEND_DT)
    into show_dt_cols
    from 
    (
        select distinct ATTEND_DT
        FROM AT_STUD_ATTENDANCE
        WHERE ATTEND_DT BETWEEN P3031_START_DATE and P3031_END_DATE
    );

    sqlqry := 'CREATE or REPLACE VIEW ATT_CLASS_REPORT AS
        SELECT ROLLNO,LAC_NO,'||show_dt_cols||',PRESENTS,OUTOF,PERCENTAGE FROM (
            SELECT ATTEND_STATUS,ATTEND_DT,
                (SELECT ROLL_NO FROM STUDENTS_DET WHERE STUDENT_ID = asa.STUDENT_ID) AS ROLLNO,
                dense_rank() OVER (ORDER BY subject) LAC_NO,
                (SELECT FROM_TIME ||  ''-''  || TO_TIME FROM TIME_MST WHERE TIME_ID = (SELECT TIME_ID_FK FROM SCHEDULE_MST WHERE SCHEDULE_ID = SCHEDULE_ID_FK)) TIME,
                (SELECT count(ATTEND_ID) FROM AT_STUD_ATTENDANCE
                    WHERE MED_ID = '||P3031_MED_ID_1||' AND
                        STUDENT_ID = asa.STUDENT_ID AND
                        STD_ID = '||P3031_STD_ID_1||' AND
                        DIV_ID = '||P3031_DIV_ID_1||' AND
                        ATTEND_STATUS =''P'' AND
                        INSTITUTE_ID = '||P0_INSTITUTE||' AND
                        AC_YEAR_ID = '||APP_ACADEMIC||' AND
                        ATTEND_DT BETWEEN '''||P3031_START_DATE||''' and '''||P3031_END_DATE||''' ) as Presents,
                (SELECT count(ATTEND_DT) FROM AT_STUD_ATTENDANCE
                    WHERE MED_ID = '||P3031_MED_ID_1||' AND
                        STUDENT_ID = asa.STUDENT_ID AND
                        STD_ID = '||P3031_STD_ID_1||' AND
                        DIV_ID = '||P3031_DIV_ID_1||' AND
                        INSTITUTE_ID = '||P0_INSTITUTE||' AND
                        AC_YEAR_ID = '||APP_ACADEMIC||' AND
                        ATTEND_DT BETWEEN '''||P3031_START_DATE||''' and '''||P3031_END_DATE||''' ) as outof,
                (select ROUND(COUNT(DECODE(ATTEND_STATUS, ''P'', 1, NULL)) / COUNT(SCHEDULE_ID_FK) * 100,2) || ''%'' 
                    from AT_STUD_ATTENDANCE 
                    WHERE MED_ID = '||P3031_MED_ID_1||' AND 
                        STUDENT_ID = asa.STUDENT_ID AND
                        STD_ID = '||P3031_STD_ID_1||' AND
                        DIV_ID = '||P3031_DIV_ID_1||' AND
                        INSTITUTE_ID = '||P0_INSTITUTE||' AND
                        AC_YEAR_ID = '||APP_ACADEMIC||' AND
                        ATTEND_DT BETWEEN '''||P3031_START_DATE||''' and '''||P3031_END_DATE||''') AS percentage
            FROM AT_STUD_ATTENDANCE asa
            WHERE MED_ID = '||P3031_MED_ID_1||' AND
                STD_ID = '||P3031_STD_ID_1||' AND
                DIV_ID = '||P3031_DIV_ID_1||' AND
                INSTITUTE_ID = '||P0_INSTITUTE||' AND
                AC_YEAR_ID = '||APP_ACADEMIC||' AND
                ATTEND_DT BETWEEN '''||P3031_START_DATE||''' and '''||P3031_END_DATE||'''
            group by grouping sets(
                (student_id,ATTEND_STATUS,ATTEND_DT,subject,SCHEDULE_ID_FK),(student_id))
        )
        PIVOT(
            max(ATTEND_STATUS)
            for ATTEND_DT in ('||date_cols||')) order by rollno,LAC_NO';

    --   dbms_output.Put_line(sqlqry);
    execute immediate sqlqry;
end Class_wise_report;

/
