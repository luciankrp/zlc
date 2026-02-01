CLASS zcl_lc_crud_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: mo_dao TYPE REF TO zif_lc_crud.

    METHODS:
      get_dao
        RETURNING VALUE(ro_result) TYPE REF TO zif_lc_crud.

ENDCLASS.



CLASS zcl_lc_crud_test IMPLEMENTATION.

  METHOD get_dao.
    IF mo_dao IS INITIAL.
      mo_dao = NEW zcl_lc_crud( ).
    ENDIF.

    RETURN mo_dao.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
*    DATA(lo_dao) = get_dao( ).
*
*    DATA(lv_created1) = lo_dao->create( is_data = VALUE #( id     = 1
*                                                           zzname = 'Test Dao' ) ).
*
*    out->write( |First record was created: { lv_created1 }| ).
*
*    DATA(lv_created2) = lo_dao->create( is_data = VALUE #( id     = 1
*                                                           zzname = 'Test Dao' ) ).
*
*    out->write( |Second record was created: { lv_created2 }| ).

    mo_dao = NEW lcl_empty_dao( ).

    DATA(lo_dao) = get_dao( ).

    DATA(lv_created1) = lo_dao->create( is_data = VALUE #( id     = 1
                                                           zzname = 'Test Dao' ) ).

    out->write( |First record was created: { lv_created1 }| ).

    DATA(lv_created2) = lo_dao->create( is_data = VALUE #( id     = 1
                                                           zzname = 'Test Dao' ) ).

    out->write( |Second record was created: { lv_created2 }| ).
  ENDMETHOD.

ENDCLASS.
