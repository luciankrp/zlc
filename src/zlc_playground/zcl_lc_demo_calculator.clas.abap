CLASS zcl_lc_demo_calculator DEFINITION
  PUBLIC
*  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES ts_number TYPE i.
    TYPES tt_number TYPE STANDARD TABLE OF ts_number WITH EMPTY KEY.

    METHODS:
      calculate
        IMPORTING
          it_number TYPE tt_number
        RETURNING VALUE(rv_result) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_demo_calculator IMPLEMENTATION.
  METHOD calculate.
*    LOOP AT it_number INTO DATA(lv_number).
*      rv_result += lv_number.
*    ENDLOOP.

    rv_result = REDUCE i( INIT sum = 0
                          FOR lv_number IN it_number
                          NEXT sum += lv_number ).
  ENDMETHOD.

ENDCLASS.
