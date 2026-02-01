  "! <p>Status values for demo processes</p>
  "! Use these constants to set/check the status of demo records.
INTERFACE zif_lc_c_demo_status
  PUBLIC.

  "! Status - Initialized
  CONSTANTS c_initialized TYPE zlc_demo_status VALUE ''.

  "! Status - Finished
  CONSTANTS c_fnished     TYPE zlc_demo_status VALUE 'X'.

  "! Status - New
  CONSTANTS c_new         TYPE zlc_demo_status VALUE '1'.

  "! Status - In Progress
  CONSTANTS c_progress    TYPE zlc_demo_status VALUE '2'.

  "! Status - In Testing
  CONSTANTS c_test        TYPE zlc_demo_status VALUE '3'.

ENDINTERFACE.
