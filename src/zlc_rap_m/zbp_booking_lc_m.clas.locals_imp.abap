CLASS lhc_booking DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS earlynumbering_cba_Booksuppl FOR NUMBERING
      IMPORTING entities FOR CREATE Booking\_Booksuppl.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Booking RESULT result.
    METHODS calculatetotalprice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR booking~calculatetotalprice.

ENDCLASS.

CLASS lhc_booking IMPLEMENTATION.

  METHOD earlynumbering_cba_Booksuppl.

* Read link data
    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Booking BY \_BookSuppl
      FROM CORRESPONDING #( entities )
      LINK DATA(lt_link_data).

* Loop all over unique key (TravelID + BookingID)
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_group_entity>)
                                GROUP BY <ls_group_entity>-%tky.

* Get highest bookingsupplement_id from bookings belonging to booking
      DATA(lv_max_booksuppl_id) = REDUCE #( INIT lv_max = CONV /dmo/booking_supplement_id( '0' )
                                            FOR ls_link IN lt_link_data USING KEY entity
                                            WHERE ( source-TravelId  = <ls_group_entity>-TravelId AND
                                                    source-BookingId = <ls_group_entity>-BookingId )
                                            NEXT lv_max = COND /dmo/booking_supplement_id(
                                                            WHEN lv_max < ls_link-target-BookingSupplementId
                                                            THEN ls_link-target-BookingSupplementId
                                                            ELSE lv_max ) ).

* Get highest assigned bookingsupplement_id from incoming entities (Draft)
      lv_max_booksuppl_id = REDUCE #( INIT lv_max = lv_max_booksuppl_id
                                      FOR ls_entity IN entities USING KEY entity
                                      WHERE ( %key-TravelId  = <ls_group_entity>-TravelId AND
                                              %key-BookingId = <ls_group_entity>-BookingId )
                                      FOR ls_booksuppl IN ls_entity-%target
                                      NEXT lv_max = COND /dmo/booking_supplement_id(
                                                     WHEN lv_max < ls_booksuppl-BookingSupplementId
                                                     THEN ls_booksuppl-BookingSupplementId
                                                     ELSE lv_max ) ).

* Loop over all entities with same key and assign new IDs
      LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entities>) USING KEY entity
                                   WHERE %key-TravelId  = <ls_group_entity>-TravelId
                                     AND %key-BookingId = <ls_group_entity>-BookingId.

        LOOP AT <ls_entities>-%target ASSIGNING FIELD-SYMBOL(<ls_booksuppl>).
          APPEND CORRESPONDING #( <ls_booksuppl> ) TO mapped-booksuppl ASSIGNING FIELD-SYMBOL(<ls_mapped_booksuppl>).
          IF <ls_booksuppl>-BookingSupplementId IS INITIAL.
            lv_max_booksuppl_id += 1.
            <ls_mapped_booksuppl>-BookingSupplementId = lv_max_booksuppl_id.
          ENDIF.
        ENDLOOP.

      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel BY \_Booking
      FIELDS ( TravelId BookingStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    result = VALUE #( FOR ls_travel IN lt_travels
                          ( %tky = ls_travel-%tky
*                            %features-%action-acceptTravel = COND #( WHEN ls_travel-%data-OverallStatus = 'A'
*                                                                     THEN if_abap_behv=>fc-o-disabled
*                                                                     ELSE if_abap_behv=>fc-o-enabled )
*                            %features-%action-rejectTravel = COND #( WHEN ls_travel-%data-OverallStatus = 'X'
*                                                                     THEN if_abap_behv=>fc-o-disabled
*                                                                     ELSE if_abap_behv=>fc-o-enabled )
                            %features-%assoc-_BookSuppl = COND #( WHEN ls_travel-%data-BookingStatus = 'X'
                                                                     THEN if_abap_behv=>fc-o-disabled
                                                                     ELSE if_abap_behv=>fc-o-enabled )
                     ) ).


  ENDMETHOD.

  METHOD calculateTotalprice.

*    DATA: lt_travel TYPE STANDARD TABLE OF zi_travel_lc_m WITH UNIQUE HASHED KEY key COMPONENTS TravelId.
*
*    lt_travel = CORRESPONDING #( keys DISCARDING DUPLICATES MAPPING TravelId = TravelId ).

    READ ENTITIES OF zi_Travel_lc_m IN LOCAL MODE
      ENTITY Booking BY \_Travel
      FIELDS ( TravelId )
      WITH VALUE #( FOR key IN keys ( %tky = key-%tky ) )
      RESULT DATA(lt_travel_link).

    MODIFY ENTITIES OF zi_travel_lc_m IN LOCAL MODE
      ENTITY Travel
      EXECUTE reCalcTotPrice
      FROM VALUE #( FOR ls_link IN lt_travel_link ( %tky = ls_link-%tky ) ).
*      FROM CORRESPONDING #( lt_travel ).

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
