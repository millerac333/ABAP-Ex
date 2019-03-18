REPORT z_abptrain_exer27.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER27
*Report Title:
*User:
*Date:
************************************************************************

*Create STRUCTURE
TYPES: BEGIN OF ls_player,
        lv_fname TYPE string,
        lv_lname TYPE string,
        lv_byear TYPE i,
       END OF ls_player.

*Create STANDARD table with variables
DATA: i_player_table TYPE STANDARD TABLE OF ls_player,
      t_year  TYPE i,
      t_age TYPE i.

*Declare parameters/types for user input
PARAMETERS: p_fname TYPE string,
            p_lname TYPE string,
            p_byear TYPE i,
            p_count TYPE i.

*Create FIELD SYMBOL to quickly point to internal table and then add/append data
FIELD-SYMBOLS: <fs_player> TYPE ls_player.

*Loop (user specifies number of iterations)
DO p_count TIMES.

*Assign Data to internal table via field-symbol
  APPEND INITIAL LINE TO i_player_table ASSIGNING <fs_player>.
  <fs_player>-lv_fname = p_fname.
  <fs_player>-lv_lname = p_lname.
  <fs_player>-lv_byear = p_byear.

*Calculate Age with current year
  t_year = sy-datum+0(4) - sy-tabix.
  t_age = t_year - <fs_player>-lv_byear.

*Ouput user input
  WRITE: / 'YEAR ', t_year, 'AGE ', t_age,
         / <fs_player>-lv_fname,
         / <fs_player>-lv_lname,
         / <fs_player>-lv_byear.
ENDDO.

*Unassign field-symbol
UNASSIGN <fs_player>.