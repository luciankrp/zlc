CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE Travel.
    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE Travel.
    METHODS setStatusOpen FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~setStatusOpen.
    METHODS calcTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~calcTotalPrice.
    METHODS recalcTotalPrice FOR MODIFY
      IMPORTING keys FOR ACTION Travel~recalcTotalPrice.
    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateCustomer.
    METHODS Edit FOR MODIFY
      IMPORTING keys FOR ACTION Travel~Edit.
    METHODS acceptTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~acceptTravel RESULT result.
    METHODS earlynumbering_cba_Booking FOR NUMBERING
      IMPORTING entities FOR CREATE Travel\_Booking.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Travel.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
    IF keys IS NOT INITIAL.

    ENDIF.
  ENDMETHOD.

  METHOD get_global_authorizations.

    IF requested_authorizations IS NOT INITIAL.

    ENDIF.



  ENDMETHOD.

  METHOD earlynumbering_create.

    LOOP AT entities INTO DATA(ls_entity_id) WHERE TravelId IS NOT INITIAL.
      APPEND CORRESPONDING #( ls_entity_id ) TO mapped-travel.
    ENDLOOP.

    DATA(lt_entities) = entities.

    DELETE lt_entities WHERE TravelId IS NOT INITIAL.

    IF lt_entities IS INITIAL.
      RETURN.
    ENDIF.

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr       = '01'
            object            = '/DMO/TRV_M'
            quantity          = CONV #( lines( lt_entities ) )
          IMPORTING
            number            = DATA(lv_latest_num)
            returncode        = DATA(lv_code)
            returned_quantity = DATA(lv_qty)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lo_error).

        LOOP AT lt_entities INTO DATA(ls_entity).
          APPEND VALUE #( %cid = ls_entity-%cid
                          %key = ls_entity-%key ) TO failed-travel.
          APPEND VALUE #( %cid = ls_entity-%cid
                          %key = ls_entity-%key
                          %msg = lo_error ) TO reported-travel.
        ENDLOOP.
        EXIT.

    ENDTRY.

    ASSERT lv_qty = lines( lt_entities ).

    DATA(lv_curr_num) = lv_latest_num - lv_qty.

    LOOP AT lt_entities INTO ls_entity.

      lv_curr_num += 1.

*      mapped-travel = VALUE #( BASE mapped-travel
*                               ( %cid = ls_entity-%cid
*                                 %is_draft = ls_entity-%is_draft
*                                 %key-TravelId = lv_curr_num ) ).

      APPEND VALUE #( %cid = ls_entity-%cid
                      %is_draft = ls_entity-%is_draft
                      %key-TravelId = lv_curr_num ) TO mapped-travel.

    ENDLOOP.


  ENDMETHOD.

  METHOD earlynumbering_cba_Booking.

    DATA : lv_max_booking TYPE /dmo/booking_id.

    READ ENTITIES OF zr_lc_travel_m IN LOCAL MODE
      ENTITY Travel BY \_Booking
      FROM CORRESPONDING #( entities )
      LINK DATA(lt_link_data).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_group_entity>)
                             GROUP BY <ls_group_entity>-TravelId .


      lv_max_booking = REDUCE #( INIT lv_max = CONV /dmo/booking_id( '0' )
                                 FOR ls_link IN lt_link_data USING KEY entity
                                      WHERE ( source-TravelId = <ls_group_entity>-TravelId  )
                                 NEXT  lv_max = COND  /dmo/booking_id( WHEN lv_max < ls_link-target-BookingId
                                                                       THEN ls_link-target-BookingId
                                                                        ELSE lv_max ) ).

      lv_max_booking  = REDUCE #( INIT lv_max = lv_max_booking
                                   FOR ls_entity IN entities USING KEY entity
                                       WHERE ( TravelId = <ls_group_entity>-TravelId  )
                                     FOR ls_booking IN ls_entity-%target
                                     NEXT lv_max = COND  /dmo/booking_id( WHEN lv_max < ls_booking-BookingId
                                                                        THEN ls_booking-BookingId
                                                                         ELSE lv_max ) ).

      LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entities>)
                        USING KEY entity
                         WHERE TravelId = <ls_group_entity>-TravelId.

        LOOP AT <ls_entities>-%target ASSIGNING FIELD-SYMBOL(<ls_booking>).

          APPEND CORRESPONDING #( <ls_booking> ) TO mapped-booking
            ASSIGNING FIELD-SYMBOL(<ls_new_map_book>).

          IF <ls_booking>-BookingId IS INITIAL.
            lv_max_booking += 10.
            <ls_new_map_book>-BookingId = lv_max_booking.
          ENDIF.

        ENDLOOP.

      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

  METHOD precheck_create.

    IF entities IS NOT INITIAL.

    ENDIF.

  ENDMETHOD.

  METHOD precheck_update.

*    LOOP AT entities INTO DATA(ls_entity) WHERE %data-BookingFee IS NOT INITIAL.
*
*      IF ls_entity-%data-BookingFee < 50.
*
*        failed-travel = VALUE #( BASE failed-travel ( %tky = ls_entity-%tky ) ).
*        reported-travel = VALUE #( BASE reported-travel ( %tky = ls_entity-%tky
*                                     %element-bookingfee = if_abap_behv=>mk-on
*                                     %msg = NEW /dmo/cm_flight_messages(
*          textid                = /dmo/cm_flight_messages=>booking_fee_invalid
*          attr1                 = CONV #( ls_entity-%data-BookingFee )
**          attr2                 =
**          attr3                 =
**          attr4                 =
**          previous              =
**          travel_id             =
**          booking_id            =
**          booking_supplement_id =
**          agency_id             =
**          customer_id           =
**          carrier_id            =
**          connection_id         =
**          supplement_id         =
**          begin_date            =
**          end_date              =
**          booking_date          =
**          flight_date           =
**          status                =
**          currency_code         =
*          severity              = if_abap_behv_message=>severity-error
**          uname                 =
*        ) ) ).
*
*      ELSEIF ls_entity-%data-BookingFee >= 50 AND
*             ls_entity-%data-BookingFee < 100.
*
**        failed-travel = VALUE #( BASE failed-travel ( %tky = ls_entity-%tky ) ).
*        reported-travel = VALUE #( BASE reported-travel ( %tky = ls_entity-%tky
*                                     %element-bookingfee = if_abap_behv=>mk-on
*                                     %msg = NEW /dmo/cm_flight_messages(
*          textid                = /dmo/cm_flight_messages=>booking_fee_invalid
*          attr1                 = CONV #( ls_entity-%data-BookingFee )
**          attr2                 =
**          attr3                 =
**          attr4                 =
**          previous              =
**          travel_id             =
**          booking_id            =
**          booking_supplement_id =
**          agency_id             =
**          customer_id           =
**          carrier_id            =
**          connection_id         =
**          supplement_id         =
**          begin_date            =
**          end_date              =
**          booking_date          =
**          flight_date           =
**          status                =
**          currency_code         =
*          severity              = if_abap_behv_message=>severity-warning
**          uname                 =
*        ) ) ).
*
*      ELSE.
*
*        reported-travel = VALUE #( BASE reported-travel ( %tky = ls_entity-%tky
*                                     %element-bookingfee = if_abap_behv=>mk-on
*                                     %msg = NEW /dmo/cm_flight_messages(
*          textid                = /dmo/cm_flight_messages=>booking_fee_invalid
*          attr1                 = CONV #( ls_entity-%data-BookingFee )
**          attr2                 =
**          attr3                 =
**          attr4                 =
**          previous              =
**          travel_id             =
**          booking_id            =
**          booking_supplement_id =
**          agency_id             =
**          customer_id           =
**          carrier_id            =
**          connection_id         =
**          supplement_id         =
**          begin_date            =
**          end_date              =
**          booking_date          =
**          flight_date           =
**          status                =
**          currency_code         =
*          severity              = if_abap_behv_message=>severity-success
**          uname                 =
*        ) ) ).
*
*      ENDIF.
*
*    ENDLOOP.

  ENDMETHOD.

  METHOD setStatusOpen.

    READ ENTITIES OF zr_lc_travel_m IN LOCAL MODE
      ENTITY Travel
      FIELDS ( OverallStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    DELETE lt_travels WHERE OverallStatus IS NOT INITIAL.

    CHECK lt_travels IS NOT INITIAL.

    MODIFY ENTITIES OF zr_lc_travel_m IN LOCAL MODE
      ENTITY Travel
      UPDATE FIELDS ( OverallStatus )
      WITH VALUE #( FOR ls_travel IN lt_travels ( %tky = ls_travel-%tky
                                                  %data-OverallStatus = 'O' ) ).

  ENDMETHOD.

  METHOD calcTotalPrice.

*   Execute internal action to update Total Price
    MODIFY ENTITIES OF zr_lc_travel_m IN LOCAL MODE
      ENTITY Travel
      EXECUTE recalcTotalPrice
      FROM CORRESPONDING #( keys ).

  ENDMETHOD.

  METHOD recalcTotalPrice.

    DATA: lt_update TYPE TABLE FOR UPDATE zr_lc_travel_m.

    READ ENTITIES OF zr_lc_travel_m IN LOCAL MODE
      ENTITY Travel
      FIELDS ( BookingFee TotalPrice )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    CHECK lt_travels IS NOT INITIAL.

    lt_update = VALUE #( FOR ls_travel IN lt_travels (
                                    %tky = ls_travel-%tky
                                    TotalPrice = ls_travel-%data-TotalPrice + ls_travel-%data-BookingFee
                                    %control-TotalPrice = if_abap_behv=>mk-on  ) ).

    MODIFY ENTITIES OF zr_lc_travel_m IN LOCAL MODE
      ENTITY Travel
      UPDATE FROM lt_update.

  ENDMETHOD.

  METHOD validateCustomer.

    READ ENTITIES OF zr_lc_travel_m IN LOCAL MODE
      ENTITY Travel
      FIELDS ( CustomerId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_customers).

    LOOP AT lt_customers INTO DATA(ls_customer).

*     Reported
      reported-travel = VALUE #( BASE reported-travel (
                                   %tky = ls_customer-%tky
                                   %state_area = 'VALIDATE_CUSTOMER'  )  ).

      IF ls_customer-%data-CustomerId IS INITIAL.

*       Failed
        failed-travel = VALUE #( BASE failed-travel ( %tky = ls_customer-%tky ) ).

*       Reported
        reported-travel = VALUE #( BASE reported-travel (
                                     %tky = ls_customer-%tky
                                     %state_area = 'VALIDATE_CUSTOMER'
                                     %msg = NEW /dmo/cm_flight_messages(
                                                      textid   = /dmo/cm_flight_messages=>enter_customer_id
                                                      severity = if_abap_behv_message=>severity-error )
                                     %element-customerid = if_abap_behv=>mk-on  ) ).

      ENDIF.

    ENDLOOP.


  ENDMETHOD.



  METHOD Edit.
  ENDMETHOD.

  METHOD acceptTravel.

    " Modify Status of Travel
    MODIFY ENTITIES OF zr_lc_travel_m IN LOCAL MODE
      ENTITY Travel
      UPDATE FIELDS ( OverallStatus )
      WITH VALUE #( FOR ls_key IN keys ( %tky = ls_key-%tky %data-OverallStatus = 'A' ) ).

    " Read changed data for action result
    READ ENTITIES OF zr_lc_travel_m IN LOCAL MODE
      ENTITY Travel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    " Result
    result = VALUE #( FOR ls_travel IN lt_travels ( %tky = ls_travel-%tky
                                                    %param = ls_travel ) ).

  ENDMETHOD.





ENDCLASS.
