CLASS lhc_Task DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Task.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Task.

    METHODS read FOR READ
      IMPORTING keys FOR READ Task RESULT result.

    METHODS rba_Customer FOR READ
      IMPORTING keys_rba FOR READ Task\_Customer FULL result_requested RESULT result LINK association_links.

    METHODS rba_Project FOR READ
      IMPORTING keys_rba FOR READ Task\_Project FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_Task IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Customer.
  ENDMETHOD.

  METHOD rba_Project.
  ENDMETHOD.

ENDCLASS.
