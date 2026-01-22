INTERFACE zif_lc_contact_constants
  PUBLIC .

  CONSTANTS: BEGIN OF contact_type,
               customer TYPE zlc_contact_type VALUE 'CU',
               address  TYPE zlc_contact_type VALUE 'AD',
               employee TYPE zlc_contact_type VALUE 'EM',
             END OF contact_type.
ENDINTERFACE.
