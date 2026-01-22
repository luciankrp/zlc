@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Bookings'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #M,
    dataClass: #TRANSACTIONAL
}
define view entity zi_booking_lc_m
  as select from zbooking_lc_m
  association     to parent ZI_TRAVEL_LC_M    as _Travel        on  $projection.TravelId = _Travel.TravelId
  composition [0..*] of ZI_booksuppl_lc_m as _BookSuppl
  association [1] to /dmo/carrier             as _Carrier       on  $projection.CarrierId = _Carrier.carrier_id
  association [1] to /DMO/I_Customer          as _Customer      on  $projection.CustomerId = _Customer.CustomerID
  association [1] to /DMO/I_Connection        as _Connection    on  $projection.CarrierId    = _Connection.AirlineID
                                                                and $projection.ConnectionId = _Connection.ConnectionID
  association [1] to /DMO/I_Booking_Status_VH as _BookingStatus on  $projection.BookingStatus = _BookingStatus.BookingStatus
{
  key travel_id       as TravelId,
  key booking_id      as BookingId,
      booking_date    as BookingDate,
      customer_id     as CustomerId,
      carrier_id      as CarrierId,
      connection_id   as ConnectionId,
      flight_date     as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price    as FlightPrice,
      currency_code   as CurrencyCode,
      booking_status  as BookingStatus,
      // Etag (abp_locinst_lastchange_tstmpl)
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at as LastChangedAt,
      
      _BookSuppl,
      _Travel,
      _Carrier,
      _Customer,
      _Connection,
      _BookingStatus
}
