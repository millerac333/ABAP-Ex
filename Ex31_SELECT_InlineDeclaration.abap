REPORT z_abptrain_acm_exer31.

TYPES: BEGIN OF ts_spfli,
         carrid    TYPE spfli-carrid,
         connid    TYPE spfli-connid,
         countryfr TYPE spfli-countryfr,
       END OF ts_spfli.

*specify/fill data to 'object'
SELECT carrid,
       connid,
       countryfr
FROM spfli
*Inline Declaration
  INTO @DATA(wa_spfli).

*check object
  WRITE: wa_spfli-carrid,
        / wa_spfli-connid,
        / wa_spfli-countryfr.

ENDSELECT.