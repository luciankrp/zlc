CLASS zcl_lc_test_initial_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    CLASS-METHODS create_nr_interval
      IMPORTING
        iv_object TYPE cl_numberrange_intervals=>nr_object.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lc_test_initial_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " Create Number Range Interval
    me->create_nr_interval( 'ZLCCONTACT' ).

*    " Initial Data
*    DATA lt_contacts TYPE STANDARD TABLE OF zlc_contact.
*
*    lt_contacts = VALUE #(
*
**  contact_id            = 'C1'
**  contact_type          = 'CU'
*    first_name            = 'Mario'
*    last_name             = 'Ramen'
*    birthday              = '19800801'
*    street                = 'Murloc'
*    house_number          = '01'
*    town                  = 'Cologne'
*    zip_code              = '54429'
*    country               = 'DE'
*    telephone             = '0221/1234 56789'
*    email                 = 'mario.ramen@swn.com'
*    local_created_by      = 'CB9980004749'
*    local_created_at      = '20260118115054.2783870'
*    local_last_changed_by = ''
*    local_last_changed_at = '20260118115054.2783870'
*    last_changed_at       = '20260118115054.2783870'
*
*    ( contact_id          = 'C1'
*     contact_type         = 'CU' )
*    ( contact_id          = 'E1'
*     contact_type         = 'EM' )
*
*     ).
*
*    DELETE FROM zlc_contact.
*
*    INSERT zlc_contact FROM TABLE @lt_contacts.

  ENDMETHOD.

  METHOD create_nr_interval.
*    DATA: lv_object TYPE cl_numberrange_intervals=>nr_object VALUE 'ZLCCONTACT'.

    TRY.
        cl_numberrange_intervals=>create(
      EXPORTING
        interval = VALUE #( ( nrrangenr = '01' fromnumber = '100000000' tonumber = '199999999' )
                            ( nrrangenr = '05' fromnumber = '500000000' tonumber = '599999999' )
                            ( nrrangenr = '09' fromnumber = '900000000' tonumber = '999999999' ) )
        object   = iv_object
      IMPORTING
        error    = DATA(ld_error)
    ).
      CATCH cx_number_ranges.
        "handle exception
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
