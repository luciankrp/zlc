@EndUserText.label: 'Employee Table'
@AccessControl.authorizationCheck: #NOT_ALLOWED
@Metadata.allowExtensions: true
define view entity ZI_EmployeeTable
  as select from zbc_employee_lc
  association to parent ZI_EmployeeTable_S as _EmployeeTableAll on $projection.SingletonID = _EmployeeTableAll.SingletonID
{
  key employee_id           as EmployeeId,
      first_name            as FirstName,
      last_name             as LastName,
      department            as Department,
      joining_date          as JoiningDate,
      is_active             as IsActive,
      changed_by            as ChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      @Consumption.hidden: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Consumption.hidden: true
      1                     as SingletonID,
      _EmployeeTableAll
}
