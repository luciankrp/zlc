CLASS lhc_booksuppl DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS calculateTotalprice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR BookSuppl~calculateTotalprice.

ENDCLASS.

CLASS lhc_booksuppl IMPLEMENTATION.

  METHOD calculateTotalprice.

*    DATA: lt_travel TYPE STANDARD TABLE OF zi_travel_lc_m WITH UNIQUE HASHED KEY key COMPONENTS TravelId.
*
*    lt_travel = CORRESPONDING #( keys DISCARDING DUPLICATES MAPPING TravelId = TravelId ).

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY BookSuppl BY \_Travel
      FIELDS ( TravelId )
      WITH VALUE #( FOR ls_key IN keys ( %tky = ls_key-%tky ) )
      RESULT DATA(lt_link_travel).

    MODIFY ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY travel
      EXECUTE reCalcTotPrice
      FROM VALUE #( FOR ls_link IN lt_link_travel ( %tky = ls_link-%tky ) ).

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
