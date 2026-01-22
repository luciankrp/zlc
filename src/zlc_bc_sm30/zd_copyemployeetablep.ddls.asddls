@EndUserText.label: 'Copy Employee Table'
define abstract entity ZD_CopyEmployeeTableP
{
  @EndUserText.label: 'New MedewerkerId'
  @UI.defaultValue: #( 'ELEMENT_OF_REFERENCED_ENTITY: EmployeeId' )
  EmployeeId : ZEMPLOYEE_ID;
}
