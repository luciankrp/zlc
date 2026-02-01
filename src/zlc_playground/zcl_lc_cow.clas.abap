CLASS zcl_lc_cow DEFINITION
  PUBLIC
  INHERITING FROM zcl_lc_animal
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: constructor IMPORTING iv_legs TYPE i OPTIONAL iv_arms TYPE i OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_cow IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).

    mv_legs = iv_legs.
    mv_arms = iv_arms.
  ENDMETHOD.

ENDCLASS.
