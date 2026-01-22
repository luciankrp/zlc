CLASS zcl_read_practice_lc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_read_practice_lc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*&---------------------------------------------------------------------*
*& READ Operation
*&---------------------------------------------------------------------*

**********************************************************************
* Read Entity Short form
**********************************************************************
** Read Entity Short Form 1 (Fill control structure with '01')
*    READ ENTITY zi_travel_lc_m
*      FROM VALUE #( ( %key-TravelId = '00004132'
*                      %control-AgencyId = if_abap_behv=>mk-on ) )
*      RESULT DATA(lt_result_short)
*      FAILED DATA(lt_failed_short).
*
*    IF lt_failed_short IS NOT INITIAL.
*      out->write( 'Read failed' ).
*    ELSE.
*      out->write( lt_result_short ).
*    ENDIF.

** Read Entity Short Form 2 (Control structure not required)
*    READ ENTITY zi_travel_lc_m
*      FIELDS ( AgencyId CustomerId )
*      WITH VALUE #( ( %key-TravelId = '00004132' ) )
*      RESULT DATA(lt_result_short)
*      FAILED DATA(lt_failed_short).
*
*    IF lt_failed_short IS NOT INITIAL.
*      out->write( 'Read failed' ).
*    ELSE.
*      out->write( lt_result_short ).
*    ENDIF.

** Read Entity Short Form 2 (Control structure not required)
*    READ ENTITY zi_travel_lc_m
*      ALL FIELDS
*      WITH VALUE #( ( %key-TravelId = '00004132' )
*                    ( %key-TravelId = '00004133' ) )
*      RESULT DATA(lt_result_short)
*      FAILED DATA(lt_failed_short).
*
*    IF lt_failed_short IS NOT INITIAL.
*      out->write( 'Read failed' ).
*    ELSE.
*      out->write( lt_result_short ).
*    ENDIF.

** Read Entity Short Form 2 (Control structure not required)
** By Association
*    READ ENTITY zi_travel_lc_m
*      BY \_Booking
*      ALL FIELDS
*      WITH VALUE #( ( %key-TravelId = '00004132' )
*                    ( %key-TravelId = '00004133' ) )
*      RESULT DATA(lt_result_short)
*      FAILED DATA(lt_failed_short).
*
*    IF lt_failed_short IS NOT INITIAL.
*      out->write( 'Read failed' ).
*    ELSE.
*      out->write( lt_result_short ).
*    ENDIF.

**********************************************************************
* Read Entity Long form
**********************************************************************
** Read Entity Long Form (from ROOT entity)
*    READ ENTITIES OF zi_travel_lc_m
*      ENTITY Travel " BY \_Booking
*      ALL FIELDS
*      WITH VALUE #( ( %key-TravelId = '00004132' )
*                    ( %key-TravelId = '00004133' )  )
*      RESULT DATA(lt_result_long)
*
*      ENTITY Booking
*      ALL FIELDS
*      WITH VALUE #( ( %key-TravelId = '00004132'
*                      %key-BookingId = '0001' ) )
*      RESULT DATA(lt_result_booking)
*
*      FAILED DATA(lt_failed_short).
*
*    IF lt_failed_short IS NOT INITIAL.
*      out->write( 'Read failed' ).
*    ELSE.
*      out->write( lt_result_long ).
*      out->write( lt_result_booking ).
*    ENDIF.

**********************************************************************
* Read Entity Dynamic form
**********************************************************************
    DATA: it_optab          TYPE abp_behv_retrievals_tab,
          it_travel         TYPE TABLE FOR READ IMPORT zi_travel_lc_m,
          it_travel_restul  TYPE TABLE FOR READ RESULT zi_travel_lc_m,
          it_booking        TYPE TABLE FOR READ IMPORT zi_travel_lc_m\_Booking,
          it_booking_restul TYPE TABLE FOR READ RESULT zi_travel_lc_m\_Booking.

    it_travel = VALUE #( ( %key-TravelId = '00004132'
                           %control = VALUE #( AgencyId = if_abap_behv=>mk-on
                                               CustomerId = if_abap_behv=>mk-on )
                        ) ).

    it_booking = VALUE #( ( %key-TravelId = '00004132'
                            %control = VALUE #( BookingId = if_abap_behv=>mk-on
                                                BookingDate = if_abap_behv=>mk-on
                                                BookingStatus = if_abap_behv=>mk-on ) ) ).

    it_optab = VALUE #( ( op = if_abap_behv=>op-r-read
                        entity_name = 'ZI_TRAVEL_LC_M'
                        instances = REF #( it_travel )
                        results = REF #( it_travel_restul ) )
                        ( op = if_abap_behv=>op-r-read_ba
                        entity_name = 'ZI_TRAVEL_LC_M'
                        sub_name = '_BOOKING'
                        instances = REF #( it_booking )
                        results = REF #( it_booking_restul ) ) ).

    READ ENTITIES
      OPERATIONS it_optab
      FAILED DATA(lt_failed_dynamic).

    IF lt_failed_dynamic IS NOT INITIAL.
      out->write( lt_failed_dynamic ).
    ELSE.
      out->write( it_travel_restul ).
      out->write( it_booking_restul ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.





