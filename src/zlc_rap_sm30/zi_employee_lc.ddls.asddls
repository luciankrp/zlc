@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_employee_lc
  as select from zlcemployee
  association to parent zi_emp_singleton_lc as _EmployeeSingletone on $projection.EmpSingletone = _EmployeeSingletone.EmpSingletone
{
  key employee_id           as EmployeeId,
      1                     as EmpSingletone,
      first_name            as FirstName,
      last_name             as LastName,
      department            as Department,
      joining_date          as JoiningDate,
      is_active             as IsActive,

      // User who created the entry, fill automatically
      @Semantics.user.lastChangedBy: true
      changed_by            as ChangedBy,

      // Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      // Total Etag
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      _EmployeeSingletone
}
