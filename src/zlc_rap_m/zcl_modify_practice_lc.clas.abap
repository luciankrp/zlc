CLASS zcl_modify_practice_lc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_modify_practice_lc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    MODIFY ENTITY zi_travel_lc_m
*     CREATE FROM VALUE #( ( %cid = 'cid1'
*                            %data = VALUE #( BeginDate = '20251129' )
*                            %control = VALUE #( BeginDate = if_abap_behv=>mk-on )
*                        ) )
*     CREATE BY \_Booking FROM VALUE #( ( %cid_ref = 'cid1'
*                                         %target = VALUE #( ( %cid = 'cid11'
*                                                              %data = VALUE #( BookingDate = '20251129' )
*                                                              %control = VALUE #( BookingDate = if_abap_behv=>mk-on ) )
*                                                          )
*                                     ) )
*     FAILED FINAL(lt_failed)
*     MAPPED FINAL(lt_mapped)
*     REPORTED FINAL(lt_reported).
*
*    IF lt_failed IS NOT INITIAL.
*      out->write( lt_failed ).
*    ELSE.
*      COMMIT ENTITIES.
*      out->write( lt_mapped ).
*    ENDIF.
*
*    MODIFY ENTITY zi_travel_lc_m
*     DELETE FROM VALUE #( ( %key-TravelId = '00004216' ) )
*     FAILED FINAL(lt_failed1)
*     MAPPED FINAL(lt_mapped1)
*     REPORTED FINAL(lt_reported1).
*
*    IF lt_failed1 IS NOT INITIAL.
*      out->write( lt_failed1 ).
*    ELSE.
*      COMMIT ENTITIES.
*      out->write( lt_mapped1 ).
*    ENDIF.

*    MODIFY ENTITY zi_booking_lc_m
*     DELETE FROM VALUE #( ( %key-TravelId = '00004217'
*                            %key-BookingId = '0010' ) )
*     FAILED FINAL(lt_failed1)
*     MAPPED FINAL(lt_mapped1)
*     REPORTED FINAL(lt_reported1).
*
*    IF lt_failed1 IS NOT INITIAL.
*      out->write( lt_failed1 ).
*    ELSE.
*      COMMIT ENTITIES.
*      out->write( lt_mapped1 ).
*    ENDIF.

** Auto fill CID
*    MODIFY ENTITIES OF zi_travel_lc_m
*     ENTITY Travel
*     CREATE AUTO FILL CID WITH VALUE #( ( %data-BeginDate = '20251130'
*                                          %control-BeginDate = if_abap_behv=>mk-on ) )
*     FAILED FINAL(lt_failed2)
*     MAPPED FINAL(lt_mapped2)
*     REPORTED FINAL(lt_reported2).
*
*    IF lt_failed2 IS NOT INITIAL.
*      out->write( lt_failed2 ).
*    ELSE.
*      COMMIT ENTITIES.
**      out->write( lt_mapped1 ).
*    ENDIF.

** Update/Delete
*    MODIFY ENTITIES OF zi_travel_lc_m
*     ENTITY Travel
*     UPDATE FIELDS ( BeginDate )
*     WITH VALUE #( ( %key-TravelId = '00004217'
*                     %data-BeginDate = '20251201' ) )
*     ENTITY Travel
*     DELETE FROM VALUE #( ( %key-TravelId = '00004218' ) )
*     FAILED FINAL(lt_failed3)
*     MAPPED FINAL(lt_mapped3)
*     REPORTED FINAL(lt_reported3).
*
*    IF lt_failed3 IS NOT INITIAL.
*      out->write( lt_failed3 ).
*    ELSE.
*      COMMIT ENTITIES.
**      out->write( lt_mapped1 ).
*    ENDIF.

* Update (set fields)
    MODIFY ENTITY zi_travel_lc_m
     UPDATE SET FIELDS WITH VALUE #( ( %key-TravelId = '00004217'
                                       %data-BeginDate = '20251210' ) ).
    COMMIT ENTITIES.


  ENDMETHOD.
ENDCLASS.
