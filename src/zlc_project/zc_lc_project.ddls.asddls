@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Projection View'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_LC_PROJECT
  as projection on ZR_LC_PROJECT
{
  key CustomerId,
  key ProjectId,
      Title,
      Description,
      BeginDate,
      EndDate,
      Status,
      Priority,
      Budget,
      CurrencyCode,
      EstimatedHours,
      ActualHours,
      Createdby,
      Createdat,
      Localchangedby,
      Localchangedat,
      Lastchangedat,

      /* Associations */
      _Customer : redirected to parent ZC_LC_CUSTOMER,
      _Task     : redirected to composition child ZC_LC_TASK
}
