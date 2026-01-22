@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Singleton Consumption'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
    typeName: 'Manage Employee',
    typeNamePlural: 'Employee',
    title: { type: #STANDARD,
             value: 'EmpSingletone' }
}
define root view entity ZC_EMP_SINGLETON_LC
  provider contract transactional_query
  as projection on zi_emp_singleton_lc
{

      @UI.facet: [{ purpose: #STANDARD, type: #LINEITEM_REFERENCE,
                    label: 'Employee Multi Inline Edit',
                    position: 10, targetElement: '_Employee' }]
      @UI.lineItem: [{ position: 10 }]
  key EmpSingletone,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      /* Associations */
      _Employee : redirected to composition child ZC_EMPLOYEE_LC
}
