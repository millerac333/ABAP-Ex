REPORT Z_ABPTRAIN_EXER33.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER33
*Report Title:
*User:
*Date:
************************************************************************
*
TABLES spfli.

*Declare type/object for table
DATA wa_flight TYPE spfli.

SELECTION-SCREEN BEGIN OF BLOCK block1.
  PARAMETERS: p_carrid TYPE spfli-carrid,
              p_connid TYPE spfli-connid.
SELECTION-SCREEN END OF BLOCK block1.

*Single Select data from system table and put into declared type/object
SELECT *
  FROM spfli
  INTO wa_flight
  WHERE carrid = p_carrid
  AND connid = p_connid.
  WRITE: wa_flight-fltime.
ENDSELECT.

*Hacky way of checking SELECT statement without using debugger
*Completion should = 0 to pass
  WRITE: sy-subrc.
  
  ************************************************************************
  ************************************************************************
  
*ABAP 7.40

REPORT z_abptrain_acm_exer33.

TABLES spfli.

SELECTION-SCREEN BEGIN OF BLOCK block1.
PARAMETERS: p_carrid TYPE spfli-carrid,
            p_connid TYPE spfli-connid.
SELECTION-SCREEN END OF BLOCK block1.

*Single Select data from system table and put into declared type/object
SELECT *
  FROM spfli
  INTO @DATA(wa_flight)
  WHERE carrid = @p_carrid
  AND connid = @p_connid.
  WRITE: wa_flight-fltime.
ENDSELECT.

*Hacky way of checking SELECT statement without using debugger
*Completion should = 0 to pass
WRITE: sy-subrc.
