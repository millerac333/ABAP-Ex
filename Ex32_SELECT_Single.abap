REPORT Z_ABPTRAIN_EXER32.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER32
*Report Title:
*User:
*Date:
************************************************************************
*Declare type/object for table
DATA wa_spfli TYPE spfli.

*Single Select data from system table and put into declared type/object
SELECT SINGLE mandt
              carrid
              connid
              countryfr
              cityfrom
              airpfrom
              countryto
              cityto
              airpto
              fltime
              deptime
              arrtime
              distance
              distid
              fltype
              period
  FROM spfli
  INTO wa_spfli.

*Hacky way of checking SELECT statement without using debugger
*Completion should = 0 to pass
  WRITE: sy-subrc.
  
  *----------------------------------------------------------------------
REPORT Z_ABPTRAIN_ACM_EXER32.

*Single Select data from system table and put into declared type/object
*ABAP 7.40
SELECT SINGLE mandt,
              carrid,
              connid,
              countryfr,
              cityfrom,
              airpfrom,
              countryto,
              cityto,
              airpto,
              fltime,
              deptime,
              arrtime,
              distance,
              distid,
              fltype,
              period
  FROM spfli
  INTO @DATA(wa_spfli).

*Hacky way of checking SELECT statement without using debugger
*Completion should = 0 to pass
  WRITE: sy-subrc.
