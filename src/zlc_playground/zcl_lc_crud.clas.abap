CLASS zcl_lc_crud DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_lc_crud .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_crud IMPLEMENTATION.
  METHOD zif_lc_crud~create.
    INSERT zlctab FROM @is_data.

    rv_result = xsdbool( sy-subrc = 0 ).
  ENDMETHOD.

  METHOD zif_lc_crud~has_name.
    DATA(lt_data) = zif_lc_crud~read_query( it_r_name = VALUE #( ( sign = 'I' option = 'EQ' low = iv_name ) ) ).

    rv_result = xsdbool( lt_data IS NOT INITIAL ).
  ENDMETHOD.

  METHOD zif_lc_crud~read.
    SELECT SINGLE FROM zlctab
      FIELDS *
      WHERE id = @iv_id
      INTO @rs_result.
  ENDMETHOD.

  METHOD zif_lc_crud~read_query.
    SELECT FROM zlctab
      FIELDS *
      WHERE id IN @it_r_id
      INTO TABLE @rt_result.
  ENDMETHOD.
ENDCLASS.
