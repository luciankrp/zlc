CLASS lsc_zi_travel_lc_m DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zi_travel_lc_m IMPLEMENTATION.

  METHOD save_modified.

    DATA: lt_log_travel TYPE STANDARD TABLE OF zlog_travel_lc_m.

    GET TIME STAMP FIELD DATA(lv_timestamp).

    IF create-travel IS NOT INITIAL.

      LOOP AT create-travel  ASSIGNING FIELD-SYMBOL(<ls_travel>).

        TRY.
            lt_log_travel = VALUE #( BASE lt_log_travel
                                       ( change_id = cl_system_uuid=>create_uuid_x16_static(  )
                                         travelid  = <ls_travel>-%data-TravelId
                                         changing_operation = 'CREATE'
                                         changed_field_name = COND #( WHEN <ls_travel>-%control-BookingFee = cl_abap_behv=>flag_changed
                                                                      THEN 'Booking Fee'
                                                                      ELSE space )
                                         changed_value = COND #( WHEN <ls_travel>-%control-BookingFee = cl_abap_behv=>flag_changed
                                                                 THEN <ls_travel>-%data-BookingFee
                                                                 ELSE space )
                                         created_at = lv_timestamp
                                         ) ).
          CATCH cx_uuid_error.
            "handle exception
        ENDTRY.

      ENDLOOP.

**     Forbidden
*      MODIFY ENTITIES OF zi_travel_lc_m IN LOCAL MODE
*        ENTITY Travel
*        UPDATE FIELDS ( OverallStatus )
*        WITH VALUE #( FOR ls_travel IN create-travel ( %key = ls_Travel-%key %data-OverallStatus = 'O' ) ).

    ENDIF.

    IF update-travel IS NOT INITIAL.

      LOOP AT update-travel ASSIGNING <ls_travel> WHERE %control-BookingFee = cl_abap_behv=>flag_changed.

        TRY.
            lt_log_travel = VALUE #( BASE lt_log_travel
                                       ( change_id = cl_system_uuid=>create_uuid_x16_static(  )
                                         travelid  = <ls_travel>-%data-TravelId
                                         changing_operation = 'CHANGE'
                                         changed_field_name = COND #( WHEN <ls_travel>-%control-BookingFee = cl_abap_behv=>flag_changed
                                                                      THEN 'Booking Fee'
                                                                      ELSE space )
                                         changed_value = COND #( WHEN <ls_travel>-%control-BookingFee = cl_abap_behv=>flag_changed
                                                                 THEN <ls_travel>-%data-BookingFee
                                                                 ELSE space )
                                         created_at = lv_timestamp
                                         ) ).
          CATCH cx_uuid_error.
            "handle exception
        ENDTRY.

      ENDLOOP.

    ENDIF.

    IF delete-travel IS NOT INITIAL.

      LOOP AT delete-travel ASSIGNING FIELD-SYMBOL(<ls_travel_d>).

        TRY.
            lt_log_travel = VALUE #( BASE lt_log_travel
                                       ( change_id = cl_system_uuid=>create_uuid_x16_static(  )
                                         travelid  = <ls_travel_d>-TravelId
                                         changing_operation = 'DELETE'
*                                         changed_field_name = COND #( WHEN <ls_travel>-%control-BookingFee = cl_abap_behv=>flag_changed
*                                                                      THEN 'Booking Fee'
*                                                                      ELSE space )
*                                         changed_value = COND #( WHEN <ls_travel>-%control-BookingFee = cl_abap_behv=>flag_changed
*                                                                 THEN <ls_travel>-%data-BookingFee
*                                                                 ELSE space )
                                         created_at = lv_timestamp
                                         ) ).
          CATCH cx_uuid_error.
            "handle exception
        ENDTRY.

      ENDLOOP.

    ENDIF.

    IF lt_log_travel IS NOT INITIAL.
      INSERT zlog_travel_lc_m FROM TABLE @lt_log_travel.
    ENDIF.


**********************************************************************
**********************************************************************
* Unmanaged SAVE

    DATA: lt_booksuppl TYPE STANDARD TABLE OF Zbooksuppl_lc_m.

    IF create-booksuppl IS NOT INITIAL.

      lt_booksuppl = VALUE #( FOR ls_booksuppl IN create-booksuppl
                                ( booking_id = ls_booksuppl-%data-BookingId
                                  booking_supplement_id = ls_booksuppl-%data-BookingSupplementId
                                  price = ls_booksuppl-%data-Price
                                  currency_code = ls_booksuppl-%data-CurrencyCode
                                  supplement_id = ls_booksuppl-%data-SupplementId
                                  travel_id = ls_booksuppl-%data-TravelId
                                  last_changed_at = ls_booksuppl-%data-LastChangedAt
                                    ) ).

      INSERT Zbooksuppl_lc_m FROM TABLE @lt_booksuppl.

    ENDIF.

    IF update-booksuppl IS NOT INITIAL.

      lt_booksuppl = VALUE #( FOR ls_booksuppl IN update-booksuppl
                                ( booking_id = ls_booksuppl-%data-BookingId
                                  booking_supplement_id = ls_booksuppl-%data-BookingSupplementId
                                  price = ls_booksuppl-%data-Price
                                  currency_code = ls_booksuppl-%data-CurrencyCode
                                  supplement_id = ls_booksuppl-%data-SupplementId
                                  travel_id = ls_booksuppl-%data-TravelId
                                  last_changed_at = ls_booksuppl-%data-LastChangedAt
                                    ) ).

      UPDATE Zbooksuppl_lc_m FROM TABLE @lt_booksuppl.

    ENDIF.

    IF delete-booksuppl IS NOT INITIAL.

      lt_booksuppl = VALUE #( FOR ls_del IN delete-booksuppl
                                ( travel_id = ls_del-TravelId
                                  booking_id = ls_del-BookingId
                                  booking_supplement_id = ls_del-BookingSupplementId
                                    ) ).

      DELETE Zbooksuppl_lc_m FROM TABLE @lt_booksuppl.

    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS acceptTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~acceptTravel RESULT result.

    METHODS copyTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~copyTravel.

    METHODS reCalcTotPrice FOR MODIFY
      IMPORTING keys FOR ACTION Travel~reCalcTotPrice.

    METHODS rejectTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~rejectTravel RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

    METHODS validatecustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validatecustomer.
    METHODS validatedates FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validatedates.
    METHODS validatestatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validatestatus.

    METHODS calculatetotalprice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR travel~calculatetotalprice.

    METHODS setoverallstatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR travel~setoverallstatus.

    METHODS earlynumbering_cba_Booking FOR NUMBERING
      IMPORTING entities FOR CREATE Travel\_Booking.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Travel.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA(lt_entities) = entities.
    DELETE lt_entities WHERE %key-TravelId IS NOT INITIAL.

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*        ignore_buffer     =
            nr_range_nr       = '01'
            object            = '/DMO/TRV_M'
            quantity          = CONV #( lines( lt_entities  ) )
*        subobject         =
*        toyear            =
          IMPORTING
            number            = DATA(lv_latest_num)
            returncode        = DATA(lv_rc)
            returned_quantity = DATA(lv_qty)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lo_error).
        LOOP AT lt_entities INTO DATA(ls_entities).
          APPEND VALUE #( %cid = ls_entities-%cid
                          %key = ls_entities-%key ) TO failed-travel.
          APPEND VALUE #( %cid = ls_entities-%cid
                          %key = ls_entities-%key
                          %msg = lo_error ) TO reported-travel.
        ENDLOOP.
        EXIT.
    ENDTRY.

    ASSERT lv_qty = lines( lt_entities  ).

    DATA(lv_curr_num) = lv_latest_num - lv_qty.

    LOOP AT lt_entities INTO ls_entities.

      lv_curr_num = lv_curr_num + 1.

      APPEND VALUE #( %cid = ls_entities-%cid
                       travelid = lv_curr_num ) TO mapped-travel.

    ENDLOOP.

  ENDMETHOD.

  METHOD earlynumbering_cba_Booking.

    DATA : lv_max_booking TYPE /dmo/booking_id.

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
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
                                                                         ELSE lv_max )
       ).

      LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entities>)
                        USING KEY entity
                         WHERE TravelId = <ls_group_entity>-TravelId.

        LOOP AT <ls_entities>-%target ASSIGNING FIELD-SYMBOL(<ls_booking>).
          APPEND CORRESPONDING #( <ls_booking> )  TO   mapped-booking
             ASSIGNING FIELD-SYMBOL(<ls_new_map_book>).
          IF <ls_booking>-BookingId IS INITIAL.
            lv_max_booking += 10.
            <ls_new_map_book>-BookingId = lv_max_booking.
          ENDIF.

        ENDLOOP.

      ENDLOOP.

    ENDLOOP.


  ENDMETHOD.

  METHOD acceptTravel.

    MODIFY ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      UPDATE FIELDS ( OverallStatus )
      WITH VALUE #( FOR ls_key IN keys ( %tky = ls_key-%tky
                                         %data-OverallStatus = 'A' ) ).

    READ ENTITIES OF zi_Travel_lc_m IN LOCAL MODE
      ENTITY Travel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result
                            ( %tky = ls_result-%tky
                              %param = ls_result ) ).

  ENDMETHOD.

  METHOD copyTravel.

    DATA: it_travel        TYPE TABLE FOR CREATE zi_travel_lc_m,
          it_booking_cba   TYPE TABLE FOR CREATE zi_travel_lc_m\_Booking,
          it_booksuppl_cba TYPE TABLE FOR CREATE zi_booking_lc_m\_BookSuppl.

    READ TABLE keys ASSIGNING FIELD-SYMBOL(<fs_without_cid>) WITH KEY %cid = ''.
    ASSERT <fs_without_cid> IS NOT ASSIGNED.

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travel_r)
      FAILED DATA(lt_failed).

    READ ENTITIES OF zi_Travel_lc_m IN LOCAL MODE
      ENTITY Travel BY \_Booking
      ALL FIELDS WITH CORRESPONDING #( lt_travel_r )
      RESULT DATA(lt_booking_r).

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Booking BY \_BookSuppl
      ALL FIELDS WITH CORRESPONDING #( lt_booking_r )
      RESULT DATA(lt_booksuppl_r).

    LOOP AT lt_travel_r ASSIGNING FIELD-SYMBOL(<ls_travel>).

      APPEND VALUE #( %cid = keys[ KEY entity %key-TravelId = <ls_travel>-%key-TravelId  ]-%cid
                      %data = CORRESPONDING #( <ls_travel>-%data EXCEPT TravelId ) )
                TO it_travel ASSIGNING FIELD-SYMBOL(<ls_travel_create>).

      <ls_travel_create>-%data = VALUE #( BASE <ls_travel_create>-%data
                                          BeginDate = cl_abap_context_info=>get_system_date(  )
                                          EndDate   = cl_abap_context_info=>get_system_date(  ) + 10
                                          OverallStatus = 'O' ).

      APPEND VALUE #( %cid_ref = <ls_travel_create>-%cid )
                TO it_booking_cba ASSIGNING FIELD-SYMBOL(<ls_booking_create>).

      LOOP AT lt_booking_r ASSIGNING FIELD-SYMBOL(<ls_booking>) USING KEY entity
                                WHERE %key-TravelId = <ls_travel>-%key-TravelId.

        APPEND VALUE #(  %cid = <ls_travel_create>-%cid && <ls_booking>-%key-BookingId
                         %data = CORRESPONDING #( <ls_booking>-%data EXCEPT TravelId ) )
                  TO <ls_booking_create>-%target ASSIGNING FIELD-SYMBOL(<ls_booking_n>).

        <ls_booking_n>-%data-BookingStatus = 'N'.

        APPEND VALUE #( %cid_ref =  <ls_booking_n>-%cid )
                  TO it_booksuppl_cba ASSIGNING FIELD-SYMBOL(<ls_booksuppl_create>).

        LOOP AT lt_booksuppl_r ASSIGNING FIELD-SYMBOL(<ls_booksuppl>) USING KEY entity
                                         WHERE %key-TravelId = <ls_travel>-%key-TravelId
                                          AND %key-BookingId = <ls_booking>-%key-BookingId.

          APPEND VALUE #( %cid = <ls_travel_create>-%cid && <ls_booking>-%key-BookingId && <ls_booksuppl>-%key-BookingSupplementId
                          %data = CORRESPONDING #( <ls_booksuppl> EXCEPT TravelId BookingId ) )
                    TO  <ls_booksuppl_create>-%target.

        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

    MODIFY ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      CREATE
      FIELDS ( AgencyId CustomerId BeginDate EndDate BookingFee TotalPrice CurrencyCode OverallStatus Description )
      WITH it_travel
      ENTITY Travel
      CREATE BY \_Booking
      FIELDS ( BookingId BookingDate CustomerId CarrierId ConnectionId FlightDate FlightPrice CurrencyCode BookingStatus )
      WITH it_booking_cba
      ENTITY Booking
      CREATE BY \_BookSuppl
      FIELDS ( BookingSupplementId SupplementId Price CurrencyCode )
      WITH it_booksuppl_cba
      MAPPED DATA(it_mapped).

    mapped-travel = it_mapped-travel.

  ENDMETHOD.

  METHOD reCalcTotPrice.

    DATA: BEGIN OF ls_total,
            price TYPE /dmo/flight_price,
            curr  TYPE /dmo/currency_code,
          END OF ls_total,
          lt_total LIKE TABLE OF ls_total.

    DATA: lv_total TYPE /dmo/flight_price.

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      FIELDS ( BookingFee CurrencyCode )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel BY \_Booking
      FIELDS ( FlightPrice CurrencyCode )
      WITH CORRESPONDING #( lt_travels )
      RESULT DATA(lt_ba_bookings).

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY booking BY \_BookSuppl
      FIELDS ( Price CurrencyCode )
      WITH CORRESPONDING #( lt_ba_bookings )
      RESULT DATA(lt_ba_booksuppl).

    LOOP AT lt_travels ASSIGNING FIELD-SYMBOL(<ls_travel>).

      lt_total = VALUE #( ( price = <ls_travel>-%data-BookingFee
                            curr  = <ls_travel>-%data-CurrencyCode ) ).

      LOOP AT lt_ba_bookings ASSIGNING FIELD-SYMBOL(<ls_booking>)
                                    USING KEY entity
                                    WHERE %data-TravelId = <ls_travel>-%data-TravelId
                                      AND %data-CurrencyCode IS NOT INITIAL.

        APPEND VALUE #( price = <ls_booking>-%data-FlightPrice
                        curr  = <ls_booking>-%data-CurrencyCode )
                  TO lt_total.

        LOOP AT lt_ba_booksuppl ASSIGNING FIELD-SYMBOL(<ls_booksuppl>)
                                    USING KEY entity
                                    WHERE %data-TravelId = <ls_travel>-%data-TravelId
                                      AND %data-BookingId = <ls_booking>-%data-BookingId
                                      AND %data-CurrencyCode IS NOT INITIAL.

          APPEND VALUE #( price = <ls_booksuppl>-%data-Price
                          curr  = <ls_booksuppl>-%data-CurrencyCode )
                   TO lt_total.

        ENDLOOP.

      ENDLOOP.

      CLEAR <ls_travel>-TotalPrice.

      LOOP AT lt_total ASSIGNING FIELD-SYMBOL(<ls_total>).

        IF <ls_total>-curr = <ls_travel>-CurrencyCode.

        ELSE.
          /dmo/cl_flight_amdp=>convert_currency(
            EXPORTING
              iv_amount               = <ls_total>-price
              iv_currency_code_source = <ls_total>-curr
              iv_currency_code_target = <ls_travel>-CurrencyCode
              iv_exchange_rate_date   = cl_abap_context_info=>get_system_date(  )
            IMPORTING
              ev_amount               = <ls_total>-price
          ).
        ENDIF.

        <ls_travel>-TotalPrice = <ls_travel>-TotalPrice + <ls_total>-price.

      ENDLOOP.

    ENDLOOP.

    MODIFY ENTITIES OF zi_travel_lc_m IN LOCAL MODE
     ENTITY Travel
     UPDATE FIELDS ( TotalPrice )
     WITH CORRESPONDING #( lt_travels ).

  ENDMETHOD.

  METHOD rejectTravel.

    MODIFY ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      UPDATE FIELDS ( OverallStatus )
      WITH VALUE #( FOR ls_key IN keys ( %tky = ls_key-%tky
                                         %data-OverallStatus = 'X' ) ).

    READ ENTITIES OF zi_Travel_lc_m IN LOCAL MODE
      ENTITY Travel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result
                            ( %tky = ls_result-%tky
                              %param = ls_result ) ).

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      FIELDS ( TravelId OverallStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    result = VALUE #( FOR ls_travel IN lt_travels
                          ( %tky = ls_travel-%tky
                            %features-%action-acceptTravel = COND #( WHEN ls_travel-%data-OverallStatus = 'A'
                                                                     THEN if_abap_behv=>fc-o-disabled
                                                                     ELSE if_abap_behv=>fc-o-enabled )
                            %features-%action-rejectTravel = COND #( WHEN ls_travel-%data-OverallStatus = 'X'
                                                                     THEN if_abap_behv=>fc-o-disabled
                                                                     ELSE if_abap_behv=>fc-o-enabled )
                            %features-%assoc-_Booking = COND #( WHEN ls_travel-%data-OverallStatus = 'X'
                                                                     THEN if_abap_behv=>fc-o-disabled
                                                                     ELSE if_abap_behv=>fc-o-enabled )
*                            %field-OverallStatus = COND #( WHEN ls_travel-%data-OverallStatus = 'X'
*                                                                     THEN if_abap_behv=>fc-f-read_only
*                                                                     ELSE if_abap_behv=>fc-f-mandatory )
*                            %update = COND #( WHEN ls_travel-%data-OverallStatus = 'X'
*                                                                     THEN if_abap_behv=>fc-o-disabled
*                                                                     ELSE if_abap_behv=>fc-o-enabled   )
                     ) ).

  ENDMETHOD.








  METHOD validateCustomer.

    DATA: lt_cust_tmp TYPE SORTED TABLE OF /dmo/customer WITH UNIQUE KEY customer_id.

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      FIELDS ( CustomerId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    lt_cust_tmp = CORRESPONDING #( lt_travels DISCARDING DUPLICATES MAPPING customer_id = CustomerId ).
    DELETE lt_cust_tmp WHERE customer_id IS INITIAL.

    IF lt_cust_tmp IS NOT INITIAL.
      SELECT
        FROM /dmo/customer
        FIELDS customer_id
        FOR ALL ENTRIES IN @lt_cust_tmp
        WHERE customer_id = @lt_cust_tmp-customer_id
        INTO TABLE @DATA(lt_cust).
    ENDIF.

    LOOP AT lt_travels ASSIGNING FIELD-SYMBOL(<ls_travel>).

      IF <ls_travel>-CustomerId IS INITIAL
        OR NOT line_exists( lt_cust[ customer_id = <ls_travel>-CustomerId  ] ).

        APPEND VALUE #( %tky = <ls_travel>-%tky ) TO failed-travel.
        APPEND VALUE #( %tky = <ls_travel>-%tky
                        %msg = NEW /dmo/cm_flight_messages(
                                            textid                = /dmo/cm_flight_messages=>customer_unkown
                                            customer_id           = <ls_travel>-CustomerId
                                            severity              = if_abap_behv_message=>severity-error
                                            )
                        %element-CustomerId = if_abap_behv=>mk-on
                      )
                  TO reported-travel.

      ENDIF.

    ENDLOOP.


  ENDMETHOD.

  METHOD validateDates.

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      FIELDS ( BeginDate EndDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    LOOP AT lt_Travels ASSIGNING FIELD-SYMBOL(<ls_travel>).

      IF <ls_travel>-BeginDate > <ls_travel>-EndDate.

        APPEND VALUE #( %tky = <ls_travel>-%tky ) TO failed-travel.

        APPEND VALUE #( %tky = <ls_travel>-%tky
                        %msg = NEW /dmo/cm_flight_messages(
                                            textid                = /dmo/cm_flight_messages=>begin_date_bef_end_date
                                            travel_id             = <ls_travel>-TravelId
                                            begin_date            = <ls_travel>-BeginDate
                                            end_date              = <ls_travel>-EndDate
                                            severity              = if_abap_behv_message=>severity-error )
                        %element-begindate = if_abap_behv=>mk-on
                        %element-enddate = if_abap_behv=>mk-on
                      )
                  TO reported-travel.

      ELSEIF <ls_travel>-BeginDate < cl_abap_context_info=>get_system_date(  ).

        APPEND VALUE #( %tky = <ls_travel>-%tky ) TO failed-travel.

        APPEND VALUE #( %tky = <ls_travel>-%tky
                        %msg = NEW /dmo/cm_flight_messages(
                                            textid                = /dmo/cm_flight_messages=>begin_date_on_or_bef_sysdate
                                            begin_date            = <ls_travel>-BeginDate
                                            severity              = if_abap_behv_message=>severity-error )
                        %element-begindate = if_abap_behv=>mk-on
                        %element-enddate = if_abap_behv=>mk-on
                      )
                  TO reported-travel.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateStatus.

    READ ENTITY IN LOCAL MODE zi_travel_lc_m
      FIELDS ( OverallStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    LOOP AT lt_travels ASSIGNING FIELD-SYMBOL(<ls_travel>).

      CASE <ls_travel>-OverallStatus.
        WHEN 'O'.
        WHEN 'X'.
        WHEN 'A'.
        WHEN OTHERS.

          APPEND VALUE #( %tky = <ls_travel>-%tky ) TO failed-travel.

          APPEND VALUE #( %tky = <ls_travel>-%tky
                          %msg = NEW /dmo/cm_flight_messages(
                                          textid                = /dmo/cm_flight_messages=>status_invalid
                                          status                = <ls_travel>-OverallStatus
                                          severity              = if_abap_behv_message=>severity-error )
                          %element-overallstatus = <ls_travel>-OverallStatus
                        )
                    TO reported-travel.

      ENDCASE.

    ENDLOOP.

  ENDMETHOD.

  METHOD calculateTotalprice.

    MODIFY ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      EXECUTE reCalcTotPrice
      FROM CORRESPONDING #( keys ).

  ENDMETHOD.

  METHOD setOverallStatus.

    READ ENTITIES OF zi_Travel_lc_m IN LOCAL MODE
      ENTITY Travel
      FIELDS ( OverallStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    LOOP AT lt_travels ASSIGNING FIELD-SYMBOL(<ls_travel>).
      <ls_travel>-%data-OverallStatus = 'O' .
    ENDLOOP.

    MODIFY ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      UPDATE FIELDS ( OverallStatus )
      WITH CORRESPONDING #( lt_travels ).

  ENDMETHOD.

ENDCLASS.
