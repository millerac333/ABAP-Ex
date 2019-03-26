REPORT z_abptrain_acm_exer41 MESSAGE-ID zex41msgid.

*Declare tables for program
TABLES: scarr, spfli.

*Declare data types for program
TYPES: BEGIN OF lty_table,
         carrid    TYPE scarr-carrid,
         connid    TYPE spfli-connid,
         cityfrom  TYPE spfli-cityfrom,
         countryfr TYPE spfli-countryfr,
         airpfrom  TYPE spfli-airpfrom,
         cityto    TYPE spfli-cityto,
         countryto TYPE spfli-countryto,
         airpto    TYPE spfli-airpto,
         fltime    TYPE spfli-fltime,
         deptime   TYPE spfli-deptime,
         arrtime   TYPE spfli-arrtime,
         distance  TYPE spfli-distance,
         fltype    TYPE spfli-fltype,
         period    TYPE spfli-period,
       END OF lty_table.

*Declare/create internal table
DATA: lt_table TYPE STANDARD TABLE OF lty_table.

*Declare FS to point to internal table
FIELD-SYMBOLS:<fs_table> TYPE lty_table.

*Setup user input screen with parameter from ABAP dictionary
SELECTION-SCREEN BEGIN OF BLOCK b1.
PARAMETERS: p_carrid(3) TYPE c.
SELECTION-SCREEN END OF BLOCK b1.

*Event
*excute user input with select statement that will inner join two tables based on user input
AT SELECTION-SCREEN.
  SELECT a~carrid
         b~carrid
         b~connid
         b~cityfrom
         b~countryfr
         b~airpfrom
         b~cityto
         b~countryto
         b~airpto
         b~fltime
         b~deptime
         b~arrtime
         b~distance
         b~fltype
         b~period
  FROM scarr AS a INNER JOIN spfli AS b
  ON a~carrid = b~carrid
  INTO CORRESPONDING FIELDS OF TABLE lt_table
    WHERE a~carrid = p_carrid.

*Error message is incorrect Airlines Id (carrid) is entered
  IF sy-subrc >< 0.
    MESSAGE e000.
  ENDIF.

START-OF-SELECTION.
  LOOP AT lt_table ASSIGNING <fs_table>.
    WRITE: / |Airlines { <fs_table>-carrid }: { <fs_table>-connid }|,
           / |FROM: { <fs_table>-cityfrom }, { <fs_table>-countryfr } OUT OF { <fs_table>-airpfrom }|,
           / |TO: { <fs_table>-cityto }, { <fs_table>-countryto } AT { <fs_table>-airpto }|,
           / |DEPART AT: { <fs_table>-deptime }|,
           / |ARRIVE AT: { <fs_table>-arrtime }|,
           / |PLANE TYPE: { <fs_table>-fltype }|,
           / |FLT TIME: { <fs_table>-period }|,
           / |DISTANCE: { <fs_table>-distance }|.
  ENDLOOP.

  UNASSIGN <fs_table>.