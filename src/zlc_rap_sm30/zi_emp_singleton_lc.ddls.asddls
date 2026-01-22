@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Singleton Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_emp_singleton_lc
  as select from    I_Language
    left outer join zlcemployee as ztabemployee on 1 = 1
  composition [0..*] of zi_employee_lc as _Employee
{
  key 1                                 as EmpSingletone,
      max(ztabemployee.last_changed_at) as LastChangedAt,
      _Employee
}
where
  I_Language.Language = $session.system_language
