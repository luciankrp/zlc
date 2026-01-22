CLASS lsc_ZR_LC_CUSTOMER DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS adjust_numbers REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZR_LC_CUSTOMER IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD adjust_numbers.

    IF line_exists( zcl_customer_proj_buffer=>mt_customer_buffer[ flag = 'C' ] ).
      mapped-customer = VALUE #( FOR ls_customer IN zcl_customer_proj_buffer=>mt_customer_buffer WHERE ( flag = 'C' )
                                 ( %tmp-CustomerId = ls_customer-customer_id
                                   CustomerId = ls_customer-customer_id ) ).
    ENDIF.

    IF line_exists( zcl_customer_proj_buffer=>mt_project_buffer[ flag = 'C' ] ).
      mapped-project = VALUE #( FOR ls_project IN zcl_customer_proj_buffer=>mt_project_buffer WHERE ( flag = 'C' )
                                 ( %tmp-CustomerId = ls_project-customer_id
                                   %tmp-ProjectId = ls_project-project_id
                                   CustomerId = ls_project-customer_id
                                   ProjectId  = ls_project-project_id ) ).
    ENDIF.




*    DATA: lt_travel_mapping       TYPE /dmo/if_flight_legacy=>tt_ln_travel_mapping,
*          lt_booking_mapping      TYPE /dmo/if_flight_legacy=>tt_ln_booking_mapping,
*          lt_bookingsuppl_mapping TYPE /dmo/if_flight_legacy=>tt_ln_bookingsuppl_mapping.
*
*    CALL FUNCTION '/DMO/FLIGHT_TRAVEL_ADJ_NUMBERS'
*      IMPORTING
*        et_travel_mapping       = lt_travel_mapping
*        et_booking_mapping      = lt_booking_mapping
*        et_bookingsuppl_mapping = lt_bookingsuppl_mapping.
*
*
*    mapped-travel =  VALUE #( FOR ls_travel IN lt_travel_mapping ( %tmp = VALUE #( TravelID =  ls_travel-preliminary-travel_id )
*                                                                   TravelID = ls_travel-final-travel_id    ) ).
*
*
*    mapped-booking =  VALUE #( FOR ls_booking IN lt_booking_mapping ( %tmp = VALUE #( TravelID =  ls_booking-preliminary-travel_id
*                                                                                       BookingID = ls_booking-preliminary-booking_id )
*                                                                      TravelID = ls_booking-final-travel_id
*                                                                      BookingID = ls_booking-final-booking_id   ) ).

  ENDMETHOD.

  METHOD save.

    DATA lt_data TYPE STANDARD TABLE OF zlc_customer.
    DATA lt_project TYPE STANDARD TABLE OF zlc_project.

    " Customer
    " find all rows in buffer with flag = created
    lt_data = VALUE #(  FOR row IN zcl_customer_proj_buffer=>mt_customer_buffer WHERE  ( flag = 'C' ) (  row-lv_data ) ).
    IF lt_data IS NOT INITIAL.
      INSERT zlc_customer FROM TABLE @lt_data.
    ENDIF.

    " find all rows in buffer with flag = updated
    lt_data = VALUE #(  FOR row IN zcl_customer_proj_buffer=>mt_customer_buffer WHERE  ( flag = 'U' ) (  row-lv_data ) ).
    IF lt_data IS NOT INITIAL.
      UPDATE zlc_customer FROM TABLE @lt_data.
    ENDIF.

    " find all rows in buffer with flag = deleted
    lt_data = VALUE #(  FOR row IN zcl_customer_proj_buffer=>mt_customer_buffer WHERE  ( flag = 'D' ) (  row-lv_data ) ).
    IF lt_data IS NOT INITIAL.
      DELETE zlc_customer FROM TABLE @lt_data.
    ENDIF.

    " Project
    " find all rows in buffer with flag = created
    lt_project = VALUE #(  FOR ls_project IN zcl_customer_proj_buffer=>mt_project_buffer WHERE  ( flag = 'C' ) (  ls_project-lv_data ) ).
    IF lt_project IS NOT INITIAL.
      INSERT zlc_project FROM TABLE @lt_project.
    ENDIF.

    " find all rows in buffer with flag = updated
    lt_project = VALUE #(  FOR ls_project IN zcl_customer_proj_buffer=>mt_project_buffer WHERE  ( flag = 'U' ) (  ls_project-lv_data ) ).
    IF lt_project IS NOT INITIAL.
      UPDATE zlc_project FROM TABLE @lt_project.
    ENDIF.

    " find all rows in buffer with flag = deleted
    lt_project = VALUE #(  FOR ls_project IN zcl_customer_proj_buffer=>mt_project_buffer WHERE  ( flag = 'D' ) (  ls_project-lv_data ) ).
    IF lt_project IS NOT INITIAL.
      DELETE zlc_project FROM TABLE @lt_project.
    ENDIF.

*    CALL FUNCTION '/DMO/FLIGHT_TRAVEL_SAVE'.
  ENDMETHOD.

  METHOD cleanup.
    CLEAR zcl_customer_proj_buffer=>mt_customer_buffer.
*    CALL FUNCTION '/DMO/FLIGHT_TRAVEL_INITIALIZE'.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
