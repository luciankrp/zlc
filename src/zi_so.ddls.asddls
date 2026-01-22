@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface for Sales Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #M,
    dataClass: #TRANSACTIONAL
}
define root view entity ZI_SO
  as select from zlc_so
{
  key vbeln                as SalesOrder,
      erdat                as EntryDate,
      erzet                as EntryTime,
      ernam                as UserName,
      auart                as DocType,
      @Semantics.amount.currencyCode: 'Currency'
      netwr                as NetValue,
      waerk                as Currency,
      country_code         as CountryCode,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_change_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_change_at       as LastChangedAt
}
