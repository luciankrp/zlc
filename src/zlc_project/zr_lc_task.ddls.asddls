@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Task View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_LC_TASK
  as select from zlc_task as Task

  association        to parent ZR_LC_PROJECT as _Project  on  $projection.CustomerId = _Project.CustomerId
                                                          and $projection.ProjectId  = _Project.ProjectId
  association [1..1] to ZR_LC_CUSTOMER       as _Customer on  $projection.CustomerId = _Customer.CustomerId
{
  key Task.customer_id     as CustomerId,
  key Task.project_id      as ProjectId,
  key Task.task_id         as TaskId,
      Task.description     as Description,
      Task.assignee        as Assignee,
      Task.due_date        as DueDate,
      Task.status          as Status,
      Task.estimated_hours as EstimatedHours,
      Task.actual_hours    as ActualHours,
      @Semantics.user.createdBy: true
      Task.createdby       as Createdby,
      @Semantics.systemDateTime.createdAt: true
      Task.createdat       as Createdat,
      @Semantics.user.localInstanceLastChangedBy: true
      Task.localchangedby  as Localchangedby,
      @Semantics.user.localInstanceLastChangedBy: true
      Task.localchangedat  as Localchangedat,
      @Semantics.systemDateTime.lastChangedAt: true
      Task.lastchangedat   as Lastchangedat,

      //* Associations *//
      _Project,
      _Customer
}
