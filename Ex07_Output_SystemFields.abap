REPORT Z_ABPTRAIN_EXER07.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER07
*Report Title:
*User:
*Date:
************************************************************************

*using system fields with WRITE statement; system fields are variables filled by ABAP runtime.
WRITE: '**********',
*system user name
    / 'Username:', sy-uname,
*system date
    / 'Date:',     sy-datum,
*system user local time
    / 'Time:',     sy-timlo,
*system SAP logon language key
    / 'SAP Key:',  sy-langu,
    / '**********'.
