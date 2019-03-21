REPORT z_abptrain_exer30.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER30
*Report Title:
*User:
*Date:
************************************************************************
*Data structure/class
TYPES: BEGIN OF ts_spfli,
  carrid       TYPE spfli-carrid,
  connid       TYPE spfli-connid,
  countryfr    TYPE spfli-countryfr,
END OF ts_spfli.

*Data object
DATA: wa_spfli TYPE ts_spfli.

*specify/fill data to 'object'
SELECT carrid
       connid
       countryfr
FROM spfli
  INTO wa_spfli.

*check object
WRITE: wa_spfli-carrid,
      / wa_spfli-connid,
      / wa_spfli-countryfr.

ENDSELECT.
