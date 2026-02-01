CLASS zcl_lc_dog DEFINITION INHERITING FROM zcl_lc_animal
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: mv_sound TYPE string.

    METHODS: constructor.

  PROTECTED SECTION.

    METHODS: sound REDEFINITION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_lc_dog IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( 'Dog' ).
    out->write( |Number of arms: { number_of_arms( ) }| ).
    out->write( |Number of legs: { number_of_legs( ) }| ).
  ENDMETHOD.

  METHOD constructor.
    super->constructor( ).
    mv_legs = 2.
    mv_arms = 2.
    mv_sound = sound(  ).
  ENDMETHOD.

  METHOD sound.
    RETURN 'Ham Ham'.
  ENDMETHOD.

ENDCLASS.
