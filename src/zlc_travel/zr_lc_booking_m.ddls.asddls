@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking View'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_LC_BOOKING_M
  as select from zlc_booking_m as Booking

  association        to parent ZR_LC_TRAVEL_M    as _Travel        on  $projection.TravelId = _Travel.TravelId
  composition [*] of ZR_LC_BOOKSUPPL_M           as _BookingSupplement

  association [1..1] to /DMO/I_Customer          as _Customer      on  $projection.CustomerId = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier           as _Carrier       on  $projection.AirlineID = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection        as _Connection    on  $projection.AirlineID    = _Connection.AirlineID
                                                                   and $projection.ConnectionId = _Connection.ConnectionID
  association [1..1] to /DMO/I_Booking_Status_VH as _BookingStatus on  $projection.BookingStatus = _BookingStatus.BookingStatus
{
  key Booking.travel_id       as TravelId,
  key Booking.booking_id      as BookingId,
      Booking.booking_date    as BookingDate,
      Booking.customer_id     as CustomerId,
      Booking.carrier_id      as AirlineID,
      Booking.connection_id   as ConnectionId,
      Booking.flight_date     as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Booking.flight_price    as FlightPrice,
      Booking.currency_code   as CurrencyCode,
      Booking.booking_status  as BookingStatus,
      // local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Booking.last_changed_at as LastChangedAt,

      /* Associations */
      _Travel,
      _BookingSupplement,
      _Customer,
      _Carrier,
      _Connection,
      _BookingStatus
}
