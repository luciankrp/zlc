CLASS zcl_lc_demo_calc_redefinition DEFINITION
  PUBLIC INHERITING FROM zcl_lc_demo_calculator
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS calculate REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_demo_calc_redefinition IMPLEMENTATION.
  METHOD calculate.
    rv_result = REDUCE i( INIT factor = 1
                          FOR lv_number IN it_number
                          NEXT factor *= lv_number ).
  ENDMETHOD.

ENDCLASS.
