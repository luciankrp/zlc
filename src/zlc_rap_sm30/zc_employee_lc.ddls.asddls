@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
    typeName: 'Employee',
    typeNamePlural: 'Employees',
    title: { type: #STANDARD,
             value: 'EmployeeId' } }
define view entity ZC_EMPLOYEE_LC
  as projection on zi_employee_lc
{
      @UI.facet: [{ id : 'Employee', purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE,
                    label: 'Employee',
                    position: 10  }]
      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10, label: 'Employee ID' }]
  key EmployeeId,
      EmpSingletone,
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      FirstName,
      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      LastName,
      @UI.lineItem: [{ position: 35 }]
      @UI.identification: [{ position: 35 }]
      Department,
      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      JoiningDate,
      @UI.lineItem: [{ position: 50 }]
      @UI.identification: [{ position: 50 }]
      IsActive,
      @UI.hidden: true
      ChangedBy,
      @UI.hidden: true
      LocalLastChangedAt,
      @UI.hidden: true
      LastChangedAt,
      /* Associations */
      _EmployeeSingletone : redirected to parent ZC_EMP_SINGLETON_LC
}
