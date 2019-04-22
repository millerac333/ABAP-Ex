REPORT z_abptrain_acm_exer35.

**************************************************************************************
**************************************************************************************
*Report Name: Z_ABPTRAIN_ACM_EXER35
*Report Title: SELECT Statment with Aggregates
*User: Aaron Miller
*Date: 4/22/2019

*This program will illustrate the use of Aggregates within a ABAP/SQL SELECT statment

**Display from table SFLIGHT the...
**---Airline
**---Flight Number
**---Date

**Categorize if...
**---Economic Seats
**---Business Seats
**---1st Class are full or avaliable

**If available show how many seats are left
**---order by plane type
**************************************************************************************
**************************************************************************************

*This select statement will pull the following fields from system table sflight (LINE 30-37)
*Then insert them into internal table i_sflight (LINE 38)
*Then order by planetype (system field)(LINE 39)
SELECT carrid,
  connid,
  fldate,
  seatsmax - seatsocc AS availableeconomy, "Aggregate for Available Economy Seats
  seatsmax - seatsocc_b AS availablebusiness, "Aggregate for Available Business Seats
  seatsmax_f - seatsocc_f AS available1stclass, "Aggregate for Available 1st Class Seats
  planetype
  FROM sflight
  INTO TABLE @DATA(i_sflight)
  ORDER BY planetype.

*Loop created table and assign field symbol; write statement to display data in internal table
LOOP AT i_sflight ASSIGNING FIELD-SYMBOL(<fs_seating>).
  WRITE / |Airlines:{ <fs_seating>-carrid }  { <fs_seating>-connid }  Date:{ <fs_seating>-fldate }  Economy:{ <fs_seating>-availableeconomy } Business:{ <fs_seating>-availablebusiness } 1stClass:{ <fs_seating>-available1stclass } PlaneType:{
<fs_seating>-planetype }|.
ENDLOOP.