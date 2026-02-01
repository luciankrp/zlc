INTERFACE zif_lc_crud
  PUBLIC.

  TYPES ts_data   TYPE zlctab.
  TYPES tt_data   TYPE STANDARD TABLE OF ts_data WITH EMPTY KEY.

  TYPES tt_r_id   TYPE RANGE OF zlctab-id.
  TYPES tt_r_name TYPE RANGE OF zlctab-zzname.

  METHODS read
    IMPORTING iv_id            TYPE zlctab-id
    RETURNING VALUE(rs_result) TYPE ts_data.

  METHODS read_query
    IMPORTING it_r_id          TYPE tt_r_id   OPTIONAL
              it_r_name        TYPE tt_r_name OPTIONAL
    RETURNING VALUE(rt_result) TYPE tt_data.

  METHODS has_name
    IMPORTING iv_name          TYPE zlctab-zzname
    RETURNING VALUE(rv_result) TYPE abap_boolean.

  METHODS create
    IMPORTING is_data          TYPE ts_data
    RETURNING VALUE(rv_result) TYPE abap_boolean.


ENDINTERFACE.
