@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Task Projection View'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_LC_TASK
  as projection on ZR_LC_TASK
{
  key CustomerId,
  key ProjectId,
  key TaskId,
      Description,
      Assignee,
      DueDate,
      Status,
      EstimatedHours,
      ActualHours,
      Createdby,
      Createdat,
      Localchangedby,
      Localchangedat,
      Lastchangedat,

      /* Associations */
      _Project  : redirected to parent ZC_LC_PROJECT,
      _Customer : redirected to ZC_LC_CUSTOMER
      
}
