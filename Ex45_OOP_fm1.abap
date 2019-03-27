FUNCTION zex45fm1.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IM_NUM1) TYPE  I
*"     REFERENCE(IM_NUM2) TYPE  I
*"     REFERENCE(IM_NUM3) TYPE  I
*"----------------------------------------------------------------------

*clear values from global variables
  CLEAR: gv_num1,
         gv_num2,
         gv_num3.

*check to see if user filled out all fields; error message if not
  IF ( im_num1 IS INITIAL )
    OR
     ( im_num2 IS INITIAL )
    OR
     ( im_num3 IS INITIAL ).
    MESSAGE: |Please input a number for all fields| TYPE 'E'.
*check to see if user input is within specified range 0-100; error message if not
  ELSEIF
     ( im_num1 IS NOT INITIAL AND im_num1 > 100 OR im_num1 < 0 )
    OR
     ( im_num2 IS NOT INITIAL AND im_num2 > 100 OR im_num2 < 0 )
    OR
     ( im_num3 IS NOT INITIAL AND im_num3 > 100 OR im_num3 < 0 ).
    MESSAGE: |Numbers must be between 0 and 100| TYPE 'E'.
*global variables are assigned user input values
  ELSE.
    gv_num1 = im_num1.
    gv_num2 = im_num2.
    gv_num3 = im_num3.
  ENDIF.

ENDFUNCTION.