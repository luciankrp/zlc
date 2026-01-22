@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer View [Root]'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_LC_CUSTOMER
  as select from zlc_customer as Customer

  composition [*] of ZR_LC_PROJECT as _Project
{
  key Customer.customer_id    as CustomerId,
      Customer.name           as Name,
      Customer.city           as City,
      Customer.country        as Country,
      @Semantics.user.createdBy: true
      Customer.createdby      as Createdby,
      @Semantics.systemDateTime.createdAt: true
      Customer.createdat      as Createdat,
      @Semantics.user.localInstanceLastChangedBy: true
      Customer.localchangedby as Localchangedby,
      @Semantics.user.localInstanceLastChangedBy: true
      Customer.localchangedat as Localchangedat,
      @Semantics.systemDateTime.lastChangedAt: true
      Customer.lastchangedat  as Lastchangedat,

      //* Associations *//
      _Project

}
