*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_empty_dao DEFINITION.

    PUBLIC SECTION.
      INTERFACES zif_lc_crud.

ENDCLASS.

CLASS lcl_empty_dao IMPLEMENTATION.
  METHOD zif_lc_crud~create.
    RETURN abap_true.
  ENDMETHOD.

  METHOD zif_lc_crud~has_name.

  ENDMETHOD.

  METHOD zif_lc_crud~read.

  ENDMETHOD.

  METHOD zif_lc_crud~read_query.

  ENDMETHOD.

ENDCLASS.
