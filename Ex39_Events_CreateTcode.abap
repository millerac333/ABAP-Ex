REPORT z_abptrain_acm_exer39.

**************************************************************************************
**************************************************************************************
*Report Name: Z_ABPTRAIN_ACM_EXER39
*Report Title: Assign New T-Code
*User: Aaron Miller
*Date: 4/22/2019

*Illustrates running custom t-code

**CREATED T-CODE: ZACMTEST

**Assign a new Transaction Code to your prevoius exercise
**Run the programfrom SAP GUI usingthe transaction code created
**************************************************************************************
**************************************************************************************

*Declare system dictionaries
TABLES: sflight, spfli.

*Declare data types/objects/structure
TYPES: BEGIN OF lty_spfli,
         carrid TYPE spfli-carrid,
         connid TYPE spfli-connid,
       END OF lty_spfli,

       BEGIN OF lty_sflight,
         carrid   TYPE sflight-carrid,
         connid   TYPE sflight-connid,
         fldate   TYPE sflight-fldate,
         price    TYPE sflight-price,
         currency TYPE sflight-currency,
       END OF lty_sflight.

*Declare internal table for SELECT and loop
DATA: lt_spfli   TYPE STANDARD TABLE OF lty_spfli,
      lt_sflight TYPE STANDARD TABLE OF lty_sflight.

*Declare FS/pointer for created internal table
FIELD-SYMBOLS: <fs_sflight> TYPE lty_sflight.

*SQL to select fields in system dictionary
SELECT carrid
       connid
  FROM spfli
  INTO TABLE lt_spfli.

*SQL to select fields in system dictionary
SELECT carrid
       connid
       fldate
       price
       currency
FROM sflight
INTO CORRESPONDING FIELDS OF TABLE lt_sflight
FOR ALL ENTRIES IN lt_spfli
WHERE carrid = lt_spfli-carrid
AND connid = lt_spfli-connid.

*check
WRITE: sy-subrc.

*loop to add contents to created internal table
LOOP AT lt_sflight ASSIGNING <fs_sflight>.
  WRITE: / <fs_sflight>-carrid,
         / <fs_sflight>-connid,
         / <fs_sflight>-fldate,
         / <fs_sflight>-price,
         / <fs_sflight>-currency.
ENDLOOP.

*remove field-symbol
UNASSIGN <fs_sflight>.