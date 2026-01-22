CLASS lhc_Customer DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Customer RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Customer RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Customer.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Customer.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Customer.

    METHODS read FOR READ
      IMPORTING keys FOR READ Customer RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Customer.

    METHODS rba_Project FOR READ
      IMPORTING keys_rba FOR READ Customer\_Project FULL result_requested RESULT result LINK association_links.

    METHODS cba_Project FOR MODIFY
      IMPORTING entities_cba FOR CREATE Customer\_Project.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Customer RESULT result.

ENDCLASS.

CLASS lhc_Customer IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA: lv_last_customer TYPE i.

    SELECT SINGLE MAX( customer_id ) FROM zlc_customer INTO @DATA(lv_last_customer_id).

    lv_last_customer = lv_last_customer_id.

    LOOP AT entities INTO DATA(ls_create).

      " standard determinations
      ls_create-createdby = sy-uname.
      GET TIME STAMP FIELD ls_create-createdat.

      " Customer Id
      lv_last_customer += 1.
      ls_create-%data-CustomerId += lv_last_customer.

      " Update buffer
      INSERT VALUE #( flag = 'C'
                      lv_data-customer_id = ls_create-%data-CustomerId
                      lv_data-name = ls_create-%data-Name
                      lv_data-city = ls_create-%data-city
                      lv_data-country = ls_create-%data-country
                      lv_data-createdby = ls_create-%data-createdby
                      lv_data-Createdat = ls_create-%data-Createdat
                      lv_data-Localchangedby = ls_create-%data-Localchangedby
                      lv_data-localchangedat = ls_create-%data-localchangedat
                      lv_data-lastchangedat = ls_create-%data-lastchangedat
                    ) INTO TABLE  zcl_customer_proj_buffer=>mt_customer_buffer.

      APPEND VALUE #( %cid = ls_create-%cid customerid = ls_create-%data-CustomerId ) TO mapped-customer.

    ENDLOOP.

*    DATA messages   TYPE /dmo/t_message.
*    DATA legacy_entity_in  TYPE zlc_customer.
*    DATA legacy_entity_out TYPE zlc_customer.
*
*    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
*
*      legacy_entity_in = CORRESPONDING #( <entity> MAPPING FROM ENTITY USING CONTROL ).
*
*      SELECT SINGLE MAX( customer_id ) FROM zlc_customer INTO @DATA(lv_last_customer_id).
*
*      legacy_entity_out-customer_id += lv_last_customer_id.
*
*      IF legacy_entity_out-customer_id IS INITIAL.
*        APPEND VALUE #( %cid = <entity>-%cid customerid = legacy_entity_out-customer_id ) TO mapped-customer.
*      ELSE.
*
*        "fill failed return structure for the framework
*        APPEND VALUE #( customerid = legacy_entity_in-customer_id ) TO failed-customer.
*
*        "fill reported structure to be displayed on the UI
*        APPEND VALUE #( customerid = legacy_entity_in-customer_id
*                        %msg = new_message( id = messages[ 1 ]-msgid
*                                            number = messages[ 1 ]-msgno
*                                            v1 = messages[ 1 ]-msgv1
*                                            v2 = messages[ 1 ]-msgv2
*                                            v3 = messages[ 1 ]-msgv3
*                                            v4 = messages[ 1 ]-msgv4
*                                            severity = CONV #( messages[ 1 ]-msgty ) )
*       ) TO reported-customer.
*
*      ENDIF.

*      legacy_entity_in = CORRESPONDING #( <entity> MAPPING FROM ENTITY USING CONTROL ).
*
*      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_CREATE'
*        EXPORTING
*          is_travel   = CORRESPONDING /dmo/s_travel_in( legacy_entity_in )
*        IMPORTING
*          es_travel   = legacy_entity_out
*          et_messages = messages.
*
*      IF messages IS INITIAL.
*        APPEND VALUE #( %cid = <entity>-%cid travelid = legacy_entity_out-travel_id ) TO mapped-travel.
*      ELSE.
*
*        "fill failed return structure for the framework
*        APPEND VALUE #( travelid = legacy_entity_in-travel_id ) TO failed-travel.
*        "fill reported structure to be displayed on the UI
*        APPEND VALUE #( travelid = legacy_entity_in-travel_id
*                        %msg = new_message( id = messages[ 1 ]-msgid
*                                            number = messages[ 1 ]-msgno
*                                            v1 = messages[ 1 ]-msgv1
*                                            v2 = messages[ 1 ]-msgv2
*                                            v3 = messages[ 1 ]-msgv3
*                                            v4 = messages[ 1 ]-msgv4
*                                            severity = CONV #( messages[ 1 ]-msgty ) )
*       ) TO reported-travel.
*
*
*      ENDIF.
*
*  ENDLOOP.

  ENDMETHOD.

  METHOD update.

    LOOP AT entities INTO DATA(ls_update).
      READ TABLE zcl_customer_proj_buffer=>mt_customer_buffer ASSIGNING FIELD-SYMBOL(<ls_buffer>) WITH KEY customer_id = ls_update-CustomerId.
      IF sy-subrc <> 0.
        " not yet in buffer, read from table

        SELECT SINGLE * FROM zlc_customer  WHERE customer_id = @ls_update-CustomerId INTO @DATA(ls_db).

        INSERT VALUE #( flag = 'U' lv_data = ls_db ) INTO TABLE zcl_customer_proj_buffer=>mt_customer_buffer ASSIGNING <ls_buffer>.
      ENDIF.

      IF ls_update-%control-CustomerId IS NOT INITIAL. <ls_buffer>-customer_id = ls_update-CustomerId. ENDIF.
      IF ls_update-%control-Name IS NOT INITIAL. <ls_buffer>-Name = ls_update-Name. ENDIF.
      IF ls_update-%control-City IS NOT INITIAL. <ls_buffer>-City = ls_update-City. ENDIF.
      IF ls_update-%control-Country IS NOT INITIAL. <ls_buffer>-Country = ls_update-Country. ENDIF.
      IF ls_update-%control-Createdby IS NOT INITIAL. <ls_buffer>-Createdby = ls_update-Createdby. ENDIF.
      IF ls_update-%control-Createdat IS NOT INITIAL. <ls_buffer>-Createdat = ls_update-Createdat. ENDIF.
      IF ls_update-%control-Localchangedby IS NOT INITIAL. <ls_buffer>-Localchangedby = ls_update-Localchangedby. ENDIF.
      IF ls_update-%control-Localchangedat IS NOT INITIAL. <ls_buffer>-Localchangedat = ls_update-Localchangedat. ENDIF.
      IF ls_update-%control-Lastchangedat IS NOT INITIAL. <ls_buffer>-Lastchangedat = ls_update-Lastchangedat. ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD delete.

    LOOP AT keys INTO DATA(ls_delete).
      READ TABLE zcl_customer_proj_buffer=>mt_customer_buffer
          ASSIGNING FIELD-SYMBOL(<ls_buffer>) WITH KEY customer_id = ls_delete-CustomerId.

      IF sy-subrc = 0.
        " already in buffer, check why
        IF <ls_buffer>-flag = 'C'.
          "delete after create => just remove from buffer
          DELETE TABLE zcl_customer_proj_buffer=>mt_customer_buffer FROM <ls_buffer>.
        ELSE.
          <ls_buffer>-flag = 'D'.
        ENDIF.
      ELSE.
        " not yet in buffer.
        INSERT VALUE #( flag = 'D' customer_id = ls_delete-CustomerId  ) INTO TABLE zcl_customer_proj_buffer=>mt_customer_buffer.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Project.
  ENDMETHOD.

  METHOD cba_Project.

    DATA: last_project_id(6) TYPE n VALUE '000000'.

    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<customer>).

      SELECT * FROM zlc_project WHERE customer_id  = @<customer>-CustomerId
        INTO TABLE @DATA(lt_project) ##SELECT_FAE_WITH_LOB[DESCRIPTION]. "#EC CI_ALL_FIELDS_NEEDED "#EC CI_SEL_DEL

      " Set the last_booking_id to the highest value of booking_old booking_id or initial value if none exist
      last_project_id = VALUE #( lt_project[ lines( lt_project ) ]-project_id OPTIONAL ).

      LOOP AT <customer>-%target ASSIGNING FIELD-SYMBOL(<project_create>).

        last_project_id += 1.

        " Update buffer
        INSERT VALUE #( flag = 'C'
                        lv_data-customer_id = <customer>-CustomerId
                        lv_data-project_id = last_project_id
                        lv_data-title = <project_create>-title
                        lv_data-description = <project_create>-description
                        lv_data-begin_date = <project_create>-BeginDate
                        lv_data-end_date = <project_create>-EndDate
                        lv_data-status = <project_create>-Status
                        lv_data-priority = <project_create>-priority
                        lv_data-budget = <project_create>-budget
                        lv_data-currency_code = <project_create>-CurrencyCode
                        lv_data-estimated_hours = <project_create>-EstimatedHours
                        lv_data-actual_hours = <project_create>-ActualHours
                        lv_data-createdby = <project_create>-createdby
                        lv_data-Createdat = <project_create>-Createdat
                        lv_data-Localchangedby = <project_create>-Localchangedby
                        lv_data-localchangedat = <project_create>-localchangedat
                        lv_data-lastchangedat = <project_create>-lastchangedat
                      ) INTO TABLE  zcl_customer_proj_buffer=>mt_project_buffer.

        APPEND VALUE #( %cid = <project_create>-%cid
                        customerid = <customer>-CustomerId
                        projectid = last_project_id ) TO mapped-project.

*        booking = CORRESPONDING #( <booking_create> MAPPING FROM ENTITY USING CONTROL ) .

*        last_booking_id += 1.
*        booking-booking_id = last_booking_id.
*
*        CALL FUNCTION '/DMO/FLIGHT_TRAVEL_UPDATE'
*          EXPORTING
*            is_travel   = VALUE /dmo/s_travel_in( travel_id = travelid )
*            is_travelx  = VALUE /dmo/s_travel_inx( travel_id = travelid )
*            it_booking  = VALUE /dmo/t_booking_in( ( CORRESPONDING #( booking ) ) )
*            it_bookingx = VALUE /dmo/t_booking_inx(
*              (
*                booking_id  = booking-booking_id
*                action_code = /dmo/if_flight_legacy=>action_code-create
*              )
*            )
*          IMPORTING
*            et_messages = messages.
*
*        map_messages_assoc_to_booking(
*            EXPORTING
*              cid          = <booking_create>-%cid
*              messages     = messages
*            IMPORTING
*              failed_added = failed_added
*            CHANGING
*              failed       = failed-booking
*              reported     = reported-booking
*          ).
*
*        IF failed_added = abap_false.
*          INSERT
*            VALUE #(
*              %cid      = <booking_create>-%cid
*              travelid  = travelid
*              bookingid = booking-booking_id
*            ) INTO TABLE mapped-booking.
*        ENDIF.

      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

ENDCLASS.
