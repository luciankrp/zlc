@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS View Sales Order'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_SO
  provider contract transactional_query
  as projection on ZI_SO
{
  key SalesOrder,
      EntryDate,
      EntryTime,
      UserName,
      DocType,
      @Semantics.amount.currencyCode: 'Currency'
      NetValue,
      Currency,
      CountryCode,
      LocalLastChangedAt,
      LastChangedAt
}
