CLASS zcl_fill_mytable DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fill_mytable IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    " Delete
*    DELETE FROM zlc_travel_m.
*    DELETE FROM zlc_booking_m.
*    DELETE FROM zlc_booksuppl_m.
    DELETE FROM zlc_book_genre.

    " Insert
*    INSERT zlc_travel_m FROM ( SELECT * FROM /dmo/travel_m ).
*    INSERT zlc_booking_m FROM ( SELECT * FROM /dmo/booking_m ).
*    INSERT zlc_booksuppl_m FROM ( SELECT * FROM /dmo/booksuppl_m ).

    DATA: lt_book_genre TYPE TABLE OF zlc_book_genre.
    lt_book_genre = VALUE #(
                ( genre_id = 'FIC' genre = 'Fiction' )
                ( genre_id = 'LFM' genre = 'Literary Fiction/Modernism' )
                ( genre_id = 'DYS' genre = 'Dystopian' )
                ( genre_id = 'SCI' genre = 'Science Fiction' )
                ( genre_id = 'NON' genre = 'Non-Fiction' )
                ( genre_id = 'ROM' genre = 'Romance' )
                ( genre_id = 'OTH' genre = 'Other' ) ).
    INSERT zlc_book_genre FROM TABLE @lt_book_genre.

    " Output result to console
*    out->write( |Inserted { sy-dbcnt } rows into ZMY_TABLE.| ).
    out->write( 'Data fill complete!' ).

  ENDMETHOD.
ENDCLASS.
