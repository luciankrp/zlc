CLASS zlc_fill_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.



  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA : out TYPE REF TO if_oo_adt_classrun_out.
    METHODS: fill_table.
ENDCLASS.



CLASS zlc_fill_table IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    me->out = out.
    fill_table( ).
  ENDMETHOD.

  METHOD fill_table.

    DATA: lt_travel    TYPE TABLE OF zlc_travel_m, "ztravel_lc_m,
          lt_booking   TYPE TABLE OF zlc_booking_m, "zbooking_lc_m,
          lt_booksuppl TYPE TABLE OF zlc_booksuppl_m. "zbooksuppl_lc_m.

    DELETE FROM zlc_travel_m.
    DELETE FROM zlc_booking_m.
    DELETE FROM zlc_booksuppl_m.

    INSERT zlc_travel_m FROM ( SELECT * FROM /dmo/travel_m ).
    INSERT zlc_booking_m FROM ( SELECT * FROM /dmo/booking_m ).
    INSERT zlc_booksuppl_m FROM ( SELECT * FROM /dmo/booksuppl_m ).

*    SELECT * FROM /dmo/travel_m INTO TABLE @lt_travel.
*    SELECT * FROM /dmo/booking_m INTO TABLE @lt_booking.
*    SELECT * FROM /dmo/booksuppl_m INTO TABLE @lt_booksuppl.
*
*    INSERT zlc_travel_m FROM TABLE @lt_travel.
*    INSERT zlc_booking_m FROM TABLE @lt_booking.
*    INSERT zlc_booksuppl_m FROM TABLE @lt_booksuppl.


**    DATA: lt_travel TYPE TABLE OF ztravel_lc.
**
**    lt_travel = VALUE #( ( travel_id = '1000'
**                           agency_id =  '100'
**                           customer_id = '100'
**                           begin_date = '20251125'
**                           end_date = '20251130'
**                           booking_fee = 10
**                           total_price = 120
**                           currency_code = '$' )
**
**                         ( travel_id = '1001'
**                           agency_id =  '101'
**                           customer_id = '100'
**                           begin_date = '20251125'
**                           end_date = '20251130'
**                           booking_fee = 15
**                           total_price = 220
**                           currency_code = '$' )
**
**                            ).
**
**    INSERT ztravel_lc FROM TABLE @lt_travel.
**
**    IF sy-subrc EQ 0.
**      out->write( lt_travel ).
**    ENDIF.

  ENDMETHOD.

ENDCLASS.
