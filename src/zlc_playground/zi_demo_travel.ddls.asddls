@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Interface'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@AbapCatalog.extensibility: {
    extensible: true,
    elementSuffix: 'ZTR',
    quota: {
        maximumFields: 1000,
        maximumBytes: 100000
    },
    dataSources: [ '_Travel', '_Agency' ],
    allowNewDatasources: false
}
define view entity zi_demo_travel
  as select from /dmo/travel as _Travel
  association [1] to I_Currency  as _Currency on $projection.CurrencyCode = _Currency.Currency
  association [1] to /dmo/agency as _Agency   on $projection.AgencyId = _Agency.agency_id
{
  key _Travel.travel_id     as TravelId,
      _Travel.agency_id     as AgencyId,
      _Travel.customer_id   as CustomerId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      _Travel.total_price   as TotalPrice,
      _Travel.currency_code as CurrencyCode,
      _Travel.description   as Description,

      // public associations
      _Currency,
      _Agency
}
