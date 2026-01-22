CLASS zcl_lc_contact_behavior DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR BEHAVIOR OF ZLC_R_ContactTP.

  PUBLIC SECTION.
    TYPES keys_address  TYPE TABLE FOR ACTION IMPORT zlc_r_contacttp\\contact~createaddress.
    TYPES keys_customer TYPE TABLE FOR ACTION IMPORT zlc_r_contacttp\\contact~createcustomer.
    TYPES keys_employee TYPE TABLE FOR ACTION IMPORT zlc_r_contacttp\\contact~createemployee.
    TYPES mapped TYPE RESPONSE FOR MAPPED EARLY zlc_r_contacttp.
    TYPES failed TYPE RESPONSE FOR FAILED EARLY zlc_r_contacttp.
    TYPES reported TYPE RESPONSE FOR REPORTED EARLY zlc_r_contacttp.
    TYPES imported_keys TYPE TABLE FOR VALIDATION zlc_r_contacttp\\contact~checkcontactforcustomer.
    TYPES read_result TYPE TABLE FOR READ RESULT zlc_r_contacttp\\contact.

    METHODS get_selected_entries
      IMPORTING
        keys          TYPE imported_keys
      RETURNING
        VALUE(result) TYPE read_result.

    METHODS: create_new_address
      IMPORTING
        keys     TYPE keys_address
      EXPORTING
        mapped   TYPE mapped
        failed   TYPE failed
        reported TYPE reported.

    METHODS: create_new_customer
      IMPORTING
        keys     TYPE keys_customer
      EXPORTING
        mapped   TYPE mapped
        failed   TYPE failed
        reported TYPE reported.

    METHODS: create_new_employee
      IMPORTING
        keys     TYPE keys_employee
      EXPORTING
        mapped   TYPE mapped
        failed   TYPE failed
        reported TYPE reported.

    METHODS: get_new_number
      IMPORTING
        pid           TYPE abp_behv_pid
      RETURNING
        VALUE(result) TYPE zlc_contact_id.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_contact_behavior IMPLEMENTATION.
  METHOD create_new_address.
    MODIFY ENTITIES OF zlc_r_contacttp IN LOCAL MODE
      ENTITY Contact
      CREATE FROM VALUE #( FOR key IN keys
                            ( %cid = key-%cid
                             %is_draft = key-%param-%is_draft
                             ContactTypeInt = zif_lc_contact_constants=>contact_type-address
                             %control-ContactTypeInt = if_abap_behv=>mk-on
                              ) )
      MAPPED mapped
      REPORTED reported
      FAILED failed.
  ENDMETHOD.
  METHOD create_new_customer.
    MODIFY ENTITIES OF zlc_r_contacttp IN LOCAL MODE
      ENTITY Contact
      CREATE FROM VALUE #( FOR key IN keys
                            ( %cid = key-%cid
                             %is_draft = key-%param-%is_draft
                             ContactTypeInt = zif_lc_contact_constants=>contact_type-customer
                             %control-ContactTypeInt = if_abap_behv=>mk-on
                              ) )
      MAPPED mapped
      REPORTED reported
      FAILED failed.
  ENDMETHOD.
  METHOD create_new_employee.
    MODIFY ENTITIES OF zlc_r_contacttp IN LOCAL MODE
      ENTITY Contact
      CREATE FROM VALUE #( FOR key IN keys
                            ( %cid = key-%cid
                             %is_draft = key-%param-%is_draft
                             ContactTypeInt = zif_lc_contact_constants=>contact_type-employee
                             %control-ContactTypeInt = if_abap_behv=>mk-on
                              ) )
      MAPPED mapped
      REPORTED reported
      FAILED failed.
  ENDMETHOD.

  METHOD get_new_number.
    DATA number_range TYPE cl_numberrange_runtime=>nr_interval.
    DATA external_number TYPE n LENGTH 9.

    READ ENTITIES OF ZLC_R_ContactTP IN LOCAL MODE
      ENTITY Contact
      FIELDS ( ContactTypeInt )
      WITH VALUE #( ( %pid = pid ) )
      RESULT DATA(new_entries).

    TRY.
        DATA(new_entry) = new_entries[ 1 ].
      CATCH cx_sy_itab_line_not_found.
        RETURN 'EMPTY'.
    ENDTRY.

    CASE new_entry-ContactTypeInt.
      WHEN zif_lc_contact_constants=>contact_type-address.
        number_range = '09'.
      WHEN zif_lc_contact_constants=>contact_type-customer.
        number_range = '05'.
      WHEN zif_lc_contact_constants=>contact_type-employee.
        number_range = '01'.
    ENDCASE.

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr       = number_range
            object            = 'ZLCCONTACT'
*        quantity          =
*        subobject         =
*        toyear            =
          IMPORTING
            number            = DATA(new_number)
            returncode        = DATA(return_code)
*        returned_quantity =
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.

    external_number = new_number.

    DATA(new_id) = substring( val = new_entry-ContactTypeInt
                              off = 0
                              len = 1 ) && external_number.

    RETURN new_id.

  ENDMETHOD.


  METHOD get_selected_entries.
    READ ENTITIES OF ZLC_R_ContactTP IN LOCAL MODE
      ENTITY Contact
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT result.
  ENDMETHOD.

ENDCLASS.
