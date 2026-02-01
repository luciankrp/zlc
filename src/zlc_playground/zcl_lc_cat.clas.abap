CLASS zcl_lc_cat DEFINITION INHERITING FROM zcl_lc_animal
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: constructor.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_cat IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    mv_legs = 2.
    mv_arms = 2.
  ENDMETHOD.
ENDCLASS.
