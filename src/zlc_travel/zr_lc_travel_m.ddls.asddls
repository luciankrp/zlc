@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel View - Root Entity'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZR_LC_TRAVEL_M
  as select from zlc_travel_m as Travel

  composition [*] of ZR_LC_BOOKING_M             as _Booking

  association [1]    to /DMO/I_Agency               as _Agency   on $projection.AgencyId = _Agency.AgencyID
  association [1]    to /DMO/I_Customer             as _Customer on $projection.CustomerId = _Customer.CustomerID
  association [1]    to I_Currency                  as _Currency on $projection.CurrencyCode = _Currency.Currency
  association [1..1] to /DMO/I_Overall_Status_VH as _Status      on $projection.OverallStatus = _Status.OverallStatus

{
  key Travel.travel_id       as TravelId,
      Travel.agency_id       as AgencyId,
      Travel.customer_id     as CustomerId,
      Travel.begin_date      as BeginDate,
      Travel.end_date        as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.booking_fee     as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.total_price     as TotalPrice,
      Travel.currency_code   as CurrencyCode,
      Travel.description     as Description,
      Travel.overall_status  as OverallStatus,
      @Semantics.user.createdBy: true
      Travel.created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      Travel.created_at      as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      Travel.last_changed_by as LastChangedBy,
      // local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Travel.last_changed_at as LastChangedAt,
      // total ETag field
      @Semantics.systemDateTime.lastChangedAt: true
      Travel.lastchgat       as LastChgAt,

      /* Associations */
      _Booking,
      _Agency,
      _Customer,
      _Currency,
      _Status
}
