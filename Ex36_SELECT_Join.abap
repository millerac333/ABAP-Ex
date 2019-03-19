*Declare SAP tables being used
TABLES: sflight, spfli, scarr.

*Declare data/structure/types used from above tables for created internal table
TYPES: BEGIN OF lty_testflight,
        fldate   TYPE sflight-fldate,
        carrname TYPE scarr-carrname,
        connid   TYPE spfli-connid,
        carrid   TYPE sflight-carrid,
        url      TYPE scarr-url,
       END OF lty_testflight.

*create internal table via structure written above
DATA: lt_fly TYPE STANDARD TABLE OF lty_testflight.

*declare field symbol to point to memory address of created table
FIELD-SYMBOLS: <lfs_test> TYPE lty_testflight.

*SELECT statment using aliases
*Select specific information from SAP tables
SELECT aa~carrid
       aa~connid
       aa~fldate
       bb~carrname
       bb~url
*create aliases
FROM sflight AS aa INNER JOIN scarr AS bb
*inner join 'related column' on 'aa' and 'bb'
ON aa~carrid = bb~carrid
*move inner joined data into created internal table
INTO CORRESPONDING FIELDS OF TABLE lt_fly
*specify data
WHERE aa~carrid = 'LH'
*specify data
AND aa~connid = 401.

*use loop to display/write table
LOOP AT lt_fly ASSIGNING <lfs_test>.
  WRITE: / <lfs_test>-carrid,
         / <lfs_test>-connid,
         / <lfs_test>-fldate,
         / <lfs_test>-carrname,
         / <lfs_test>-url.
ENDLOOP.

*remove field symbol
UNASSIGN: <lfs_test>.

*hacky check
WRITE: / sy-subrc.