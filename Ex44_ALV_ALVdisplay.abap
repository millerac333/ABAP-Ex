REPORT Z_ABPTRAIN_ACM_EXER44.

************************************************************************
************************************************************************
*Report Name: Z_ABPTRAIN_ACM_EXER44
*Report Title: ALV Display
*User: Aaron Miller
*Date: 04/22/2019

*This program will illustrate the use of ALV declaration for user to view table

**From the last select statements exercise(Ex37),
**copy the program and display it using ALV declaration.
************************************************************************
************************************************************************

*Declare system dictionaries
TABLES: sflight, spfli.

*Declare data types/objects/structure
TYPES: BEGIN OF lty_spfli,
       carrid TYPE spfli-carrid,
       connid TYPE spfli-connid,
  END OF lty_spfli,
*Declare data types/objects/structure
BEGIN OF lty_sflight,
  carrid   TYPE sflight-carrid,
  connid   TYPE sflight-connid,
  fldate   TYPE sflight-fldate,
  price    TYPE sflight-price,
  currency TYPE sflight-currency,
END OF lty_sflight.

*Declare internal tables
DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
      lt_spfli TYPE STANDARD TABLE OF lty_spfli,
      lt_sflight TYPE STANDARD TABLE OF lty_sflight.

*create catalog for ALV grid display
lt_fieldcat = VALUE #( ( fieldname = 'carrid'   seltext_l = 'Airline ID' )
                       ( fieldname = 'connid'   seltext_l = 'Flight Number' )
                       ( fieldname = 'fldate'   seltext_l = 'Flight Date' )
                       ( fieldname = 'price'    seltext_l = 'Airfare' )
                       ( fieldname = 'currency' seltext_l = 'Currency' ) ).

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

*Calling ALV function to display table from Select statements
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    it_fieldcat = lt_fieldcat
  TABLES
    t_outtab = lt_sflight
  EXCEPTIONS
    program_error = 1
    OTHERS = 2.

IF sy-subrc <> 0.
  MESSAGE |DANGER WILL ROBINSON, DANGER: ERROR IN PROGRAM| TYPE 'e'.
ENDIF.