CLASS zcl_lc_demo_animal DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_demo_animal IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(lo_animal) = NEW zcl_lc_animal( ).

    out->write( 'Animal' ).
    out->write( |Number of arms: { lo_animal->number_of_arms( ) }| ).
    out->write( |Number of legs: { lo_animal->number_of_legs( ) }| ).

    DATA(lo_dog) = NEW zcl_lc_dog( ).

    out->write( 'Dog' ).
    out->write( |Number of arms: { lo_dog->number_of_arms( ) }| ).
    out->write( |Number of legs: { lo_dog->number_of_legs( ) }| ).
    out->write( |Say hello: { lo_dog->mv_sound }| ).

    lo_animal = NEW zcl_lc_spider( ).

    out->write( 'Spider' ).
    out->write( |Number of arms: { lo_animal->number_of_arms( ) }| ).
    out->write( |Number of legs: { lo_animal->number_of_legs( ) }| ).

    lo_animal = NEW zcl_lc_cat( ).

    out->write( 'Cat' ).
    out->write( |Number of arms: { lo_animal->number_of_arms( ) }| ).
    out->write( |Number of legs: { lo_animal->number_of_legs( ) }| ).

    lo_animal = NEW zcl_lc_cow( iv_legs = 4 ).

    out->write( 'Cow' ).
    out->write( |Number of arms: { lo_animal->number_of_arms( ) }| ).
    out->write( |Number of legs: { lo_animal->number_of_legs( ) }| ).

*    DATA lr_horse TYPE REF TO zif_lc_animal.
*    lr_horse = NEW zcl_lc_horse( ).
*    lr_horse->number_of_arms( ).
*    lr_horse->number_of_legs( ).

    DATA(lo_horse) = NEW zcl_lc_horse( ).

    lo_horse->zif_lc_animal~number_of_arms( ).
    lo_horse->zif_lc_animal~number_of_legs( ).

    out->write( 'Horse' ).
    out->write( |Number of arms: { lo_horse->zif_lc_animal~mv_arms }| ).
    out->write( |Number of legs: { lo_horse->zif_lc_animal~mv_legs }| ).

    DATA(lo_snake) = NEW zcl_lc_snake( ).

    out->write( 'Snake' ).
    out->write( |Number of arms: { lo_snake->zif_lc_animal~mv_arms }| ).
    out->write( |Number of legs: { lo_snake->zif_lc_animal~mv_legs }| ).
    out->write( |Color: { lo_snake->zif_lc_animal~mv_color }| ).
    out->write( |Location: { lo_snake->zif_lc_animal~mv_location }| ).
  ENDMETHOD.
ENDCLASS.
