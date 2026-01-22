CLASS lhc_Book DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Book RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Book RESULT result.
    METHODS approve FOR MODIFY
      IMPORTING keys FOR ACTION Book~approve RESULT result.

    METHODS reject FOR MODIFY
      IMPORTING keys FOR ACTION Book~reject RESULT result.


ENDCLASS.

CLASS lhc_Book IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD approve.

    " Update Status Icon
    MODIFY ENTITIES OF zr_book IN LOCAL MODE
      ENTITY Book
      UPDATE FIELDS ( StatusIcon )
      WITH VALUE #( ( %tky = VALUE #( keys[ 1 ]-%tky OPTIONAL )
                      %data-StatusIcon = 'sap-icon://accept' ) ).

    " Read entity
    READ ENTITIES OF zr_book IN LOCAL MODE
      ENTITY book
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    " Result
    result = VALUE #( FOR ls_book IN lt_result (
                             %tky = ls_book-%tky
                             %param = ls_book ) ).

  ENDMETHOD.

  METHOD reject.

    " Update Status Icon
    MODIFY ENTITIES OF zr_book IN LOCAL MODE
      ENTITY Book
      UPDATE FIELDS ( StatusIcon )
      WITH VALUE #( ( %tky = VALUE #( keys[ 1 ]-%tky OPTIONAL )
                      %data-StatusIcon = 'sap-icon://decline' ) ).

    " Read entity
    READ ENTITIES OF zr_book IN LOCAL MODE
      ENTITY book
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    " Result
    result = VALUE #( FOR ls_book IN lt_result (
                             %tky = ls_book-%tky
                             %param = ls_book ) ).

  ENDMETHOD.

ENDCLASS.
