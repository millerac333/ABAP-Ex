REPORT Z_ABPTRAIN_EXER34.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER34
*Report Title:
*User:
*Date:
************************************************************************
*Call Dictionary
TABLES: spfli.

*create and establish relationship of standard internal table using dictionary
DATA: i_fly TYPE STANDARD TABLE OF spfli,
      wa_flight TYPE spfli,
      lv_flight TYPE string.

*create user selection screen to enter Airlines and Flight number
SELECTION-SCREEN BEGIN OF BLOCK block1.
PARAMETERS:  p_carrid       TYPE spfli-carrid,
             p_connid       TYPE spfli-connid.
SELECTION-SCREEN END OF BLOCK block1.

*select data from dictionary and insert into created table
SELECT mandt
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
  INTO CORRESPONDING FIELDS OF TABLE i_fly
  WHERE carrid = p_carrid
  AND connid = p_connid.

*Loop through created table
LOOP AT i_fly INTO wa_flight.
WRITE: / 'CLIENT', wa_flight-mandt,
       / 'AIRLINE CODE', wa_flight-carrid,
       / 'CONNECTION NUMBER', wa_flight-connid,
       / 'COUNTRY ORIGIN', wa_flight-countryfr,
       / 'DEPARTURE CITY', wa_flight-cityfrom,
       / 'DEPARTURE AIRPORT', wa_flight-airpfrom,
       / 'COUNTRY DESTINATION', wa_flight-countryto,
       / 'ARRIVAL CITY', wa_flight-cityto,
       / 'ARRIVAL AIRPORT', wa_flight-airpto,
       / 'FLIGHT TIME', wa_flight-fltime,
       / 'DEPARTURE TIME', wa_flight-deptime,
       / 'ARRIVAL TIME', wa_flight-arrtime,
       / 'TRAVEL DISTANCE', wa_flight-distance,
       / 'DISTANCE UNIT', wa_flight-distid,
       / 'FLIGHT TYPE', wa_flight-fltype,
       / 'DURATION IN DAYS', wa_flight-period.
ENDLOOP.
WRITE: / sy-subrc.