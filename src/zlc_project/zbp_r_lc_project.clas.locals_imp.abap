CLASS lhc_Project DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Project.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Project.

    METHODS read FOR READ
      IMPORTING keys FOR READ Project RESULT result.

    METHODS rba_Customer FOR READ
      IMPORTING keys_rba FOR READ Project\_Customer FULL result_requested RESULT result LINK association_links.

    METHODS rba_Task FOR READ
      IMPORTING keys_rba FOR READ Project\_Task FULL result_requested RESULT result LINK association_links.

    METHODS cba_Task FOR MODIFY
      IMPORTING entities_cba FOR CREATE Project\_Task.

ENDCLASS.

CLASS lhc_Project IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Customer.
  ENDMETHOD.

  METHOD rba_Task.
  ENDMETHOD.

  METHOD cba_Task.
  ENDMETHOD.

ENDCLASS.
