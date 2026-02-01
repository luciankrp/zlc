CLASS zcl_lc_snake DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_lc_animal.

    METHODS constructor.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_snake IMPLEMENTATION.

  METHOD zif_lc_animal~color.
    zif_lc_animal~mv_color = 'Many'.
  ENDMETHOD.

  METHOD zif_lc_animal~location.
    zif_lc_animal~mv_location = 'Earth'.
  ENDMETHOD.

  METHOD zif_lc_animal~number_of_arms.
    zif_lc_animal~mv_arms = 0.
  ENDMETHOD.

  METHOD zif_lc_animal~number_of_legs.
    zif_lc_animal~mv_legs = 0.
  ENDMETHOD.

  METHOD constructor.
    zif_lc_animal~number_of_legs( ).
    zif_lc_animal~number_of_arms( ).
    zif_lc_animal~color( ).
    zif_lc_animal~location( ).
  ENDMETHOD.

ENDCLASS.
