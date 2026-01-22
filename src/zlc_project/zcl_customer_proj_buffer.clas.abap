CLASS zcl_customer_proj_buffer DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_customer_buffer.
             INCLUDE TYPE zlc_customer AS lv_data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_customer_buffer.

    TYPES: BEGIN OF ty_project_buffer.
             INCLUDE TYPE zlc_project AS lv_data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_project_buffer.

    TYPES: BEGIN OF ty_task_buffer.
             INCLUDE TYPE zlc_task AS lv_data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_task_buffer.

    CLASS-DATA mt_customer_buffer TYPE TABLE OF ty_customer_buffer.
    CLASS-DATA mt_project_buffer TYPE TABLE OF ty_project_buffer.
    CLASS-DATA mt_task_buffer TYPE TABLE OF ty_task_buffer.

    CLASS-METHODS get_instance
      RETURNING VALUE(ro_instance) TYPE REF TO zcl_customer_proj_buffer.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: go_instance TYPE REF TO zcl_customer_proj_buffer.
ENDCLASS.

CLASS zcl_customer_proj_buffer IMPLEMENTATION.
  METHOD get_instance.
    IF go_instance IS NOT BOUND.
      go_instance = NEW #( ).
    ENDIF.
    ro_instance = go_instance.
  ENDMETHOD.
ENDCLASS.
