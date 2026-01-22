@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_LC_PROJECT
  as select from zlc_project as Poject
  
  association to parent ZR_LC_CUSTOMER as _Customer on $projection.CustomerId = _Customer.CustomerId
  
  composition [*] of ZR_LC_TASK as _Task
{
  key Poject.customer_id     as CustomerId,
  key Poject.project_id      as ProjectId,
      Poject.title           as Title,
      Poject.description     as Description,
      Poject.begin_date      as BeginDate,
      Poject.end_date        as EndDate,
      Poject.status          as Status,     
      Poject.priority        as Priority,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Poject.budget          as Budget,
      Poject.currency_code   as CurrencyCode,
      Poject.estimated_hours as EstimatedHours,
      Poject.actual_hours    as ActualHours,
      @Semantics.user.createdBy: true
      Poject.createdby       as Createdby,
      @Semantics.systemDateTime.createdAt: true
      Poject.createdat       as Createdat,
      @Semantics.user.localInstanceLastChangedBy: true
      Poject.localchangedby  as Localchangedby,
      @Semantics.user.localInstanceLastChangedBy: true
      Poject.localchangedat  as Localchangedat,
      @Semantics.systemDateTime.lastChangedAt: true
      Poject.lastchangedat   as Lastchangedat,
      
      //* Associations *//
      _Customer,
      _Task
}
