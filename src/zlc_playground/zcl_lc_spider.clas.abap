CLASS zcl_lc_spider DEFINITION INHERITING FROM zcl_lc_animal
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_spider IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    mv_arms = 0.
    mv_legs = 10.
  ENDMETHOD.

ENDCLASS.
