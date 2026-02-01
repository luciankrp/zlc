INTERFACE zif_lc_animal
  PUBLIC.

  DATA mv_legs     TYPE i.
  DATA mv_arms     TYPE i.
  DATA mv_color    TYPE string.
  DATA mv_location TYPE string.

  METHODS number_of_arms.
  METHODS number_of_legs.
  METHODS color.
  METHODS location.


ENDINTERFACE.
