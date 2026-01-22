@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Booking'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_booking_lc_m
  as projection on zi_booking_lc_m
{
  key TravelId,
  key BookingId,
      BookingDate,
      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      _Customer.LastName        as CustomerName,
      @ObjectModel.text.element: [ 'CarrierName' ]
      CarrierId,
      _Carrier.name             as CarrierName,
      ConnectionId,
      FlightDate,
      FlightPrice,
      CurrencyCode,
      @ObjectModel.text.element: [ 'BookingStatusText' ]
      BookingStatus,
      _BookingStatus._Text.Text as BookingStatusText : localized,
      LastChangedAt,
      /* Associations */
      _BookingStatus,
      _BookSuppl : redirected to composition child ZC_booksuppl_lc_m,
      _Carrier,
      _Connection,
      _Customer,
      _Travel    : redirected to parent zc_travel_lc_m
}
