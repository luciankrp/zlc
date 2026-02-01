CLASS zcl_lc_demo_is_data_valid DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    METHODS
      is_data_valid
        IMPORTING iv_data TYPE string
        RETURNING VALUE(rv_result) TYPE abap_boolean
        RAISING
          cx_sy_conversion_data_loss
          cx_sy_table_key_specification.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_demo_is_data_valid IMPLEMENTATION.
  METHOD is_data_valid.
*    DATA lv_new like zif_lc_c_demo_status=>c_new.
    CASE iv_data.
      WHEN ''.
        RAISE EXCEPTION NEW cx_sy_conversion_data_loss( ).
      WHEN 'WRONG'.
        RAISE EXCEPTION NEW cx_sy_table_key_specification( ).
      WHEN OTHERS.
        RETURN abap_true.
    ENDCASE.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    TRY.
        DATA(lv_result) = is_data_valid( 'WRONG' ).
      CATCH cx_sy_conversion_data_loss INTO DATA(lo_data_loss).
        out->write( lo_data_loss->get_text( ) ).
        RETURN.
      CATCH cx_sy_table_key_specification INTO DATA(lo_tab_key).
        out->write( lo_tab_key->get_text( ) ).
        RETURN.
    ENDTRY.

    out->write( |Result: { lv_result }| ).
  ENDMETHOD.

ENDCLASS.
