CLASS zcl_lc_demo_calc_usage DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_demo_calc_usage IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lo_calc TYPE REF TO zcl_lc_demo_calculator.

    lo_calc = NEW #( ).

    out->write( |Initial: { lo_calc->calculate( VALUE #( ( 1 ) ( 2 ) ( 3 ) ( 4 ) ( 5 ) ) ) }| ).

    lo_calc = NEW zcl_lc_demo_calc_redefinition( ).

    out->write( |Redefinition: { lo_calc->calculate( VALUE #( ( 1 ) ( 2 ) ( 3 ) ( 4 ) ( 5 ) ) ) }| ).
  ENDMETHOD.
ENDCLASS.
