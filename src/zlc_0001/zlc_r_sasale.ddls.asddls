@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZLC_GLOBALSALE'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZLC_R_SASALE
  as select from ZLC_SASALE as SASALE
  composition [1..*] of ZLC_R_SAINFO as _SAINFO
  composition [1..*] of ZLC_R_SASOLD as _SASOLD
  composition [1..*] of ZLC_R_SASELLER as _SASELLER
{
  key uuid as UUID,
  partnernumber as Partnernumber,
  salesdate as Salesdate,
  @Semantics.amount.currencyCode: 'Salescurrency'
  salesvolume as Salesvolume,
  salescurrency as Salescurrency,
  @Semantics.amount.currencyCode: 'Differencecurrency'
  differenceamount as Differenceamount,
  differencecurrency as Differencecurrency,
  @Semantics.quantity.unitOfMeasure: 'Differenceunit'
  differencequantity as Differencequantity,
  differenceunit as Differenceunit,
  salecomment as Salecomment,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  _SAINFO,
  _SASOLD,
  _SASELLER
}
