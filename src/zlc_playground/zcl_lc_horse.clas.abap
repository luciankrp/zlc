CLASS zcl_lc_horse DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_lc_animal .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_horse IMPLEMENTATION.
  METHOD zif_lc_animal~color.
    zif_lc_animal~mv_color = 'Brown'.
  ENDMETHOD.

  METHOD zif_lc_animal~location.
    zif_lc_animal~mv_location = 'West Coast'.
  ENDMETHOD.

  METHOD zif_lc_animal~number_of_arms.
   zif_lc_animal~mv_arms = 0.
  ENDMETHOD.

  METHOD zif_lc_animal~number_of_legs.
       zif_lc_animal~mv_legs = 4.
  ENDMETHOD.
ENDCLASS.
