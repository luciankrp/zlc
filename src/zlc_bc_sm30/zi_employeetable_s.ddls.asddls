@EndUserText.label: 'Employee Table Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'EmployeeTableAll'
  }
}
define root view entity ZI_EmployeeTable_S
  as select from I_Language
    left outer join ZBC_EMPLOYEE_LC on 0 = 0
  association [0..*] to I_ABAPTransportRequestText as _ABAPTransportRequestText on $projection.TransportRequestID = _ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZI_EmployeeTable as _EmployeeTable
{
  @UI.facet: [ {
    id: 'ZI_EmployeeTable', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'Employee Table', 
    position: 1 , 
    targetElement: '_EmployeeTable'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _EmployeeTable,
  @UI.hidden: true
  max( ZBC_EMPLOYEE_LC.LAST_CHANGED_AT ) as LastChangedAtMax,
  @ObjectModel.text.association: '_ABAPTransportRequestText'
  @UI.identification: [ {
    position: 1 , 
    type: #WITH_INTENT_BASED_NAVIGATION, 
    semanticObjectAction: 'manage'
  } ]
  @Consumption.semanticObject: 'CustomizingTransport'
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  _ABAPTransportRequestText
}
where I_Language.Language = $session.system_language
