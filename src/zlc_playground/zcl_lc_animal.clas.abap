CLASS zcl_lc_animal DEFINITION
  PUBLIC
*  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      number_of_arms RETURNING VALUE(rv_arms) TYPE i,
      number_of_legs RETURNING VALUE(rv_legs) TYPE i.
  PROTECTED SECTION.
     DATA: mv_arms TYPE i.
     DATA: mv_legs TYPE i.

     METHODS: sound RETURNING VALUE(rv_sound) TYPE string.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_animal IMPLEMENTATION.
  METHOD number_of_arms.
    RETURN mv_arms.
  ENDMETHOD.

  METHOD number_of_legs.
    RETURN mv_legs.
  ENDMETHOD.

  METHOD sound.
  ENDMETHOD.

ENDCLASS.
