@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Projection View'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_LC_BOOKING_M
  as projection on ZR_LC_BOOKING_M
{
  key TravelId,
  key BookingId,
      BookingDate,
      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      _Customer.LastName        as CustomerName,
      @ObjectModel.text.element: [ 'AirlineName' ]
      AirlineID,
      _Carrier.Name             as AirlineName,
      ConnectionId,
      FlightDate,
      FlightPrice,
      CurrencyCode,
      @ObjectModel.text.element: [ 'BookingStatusText' ]
      BookingStatus,
      _BookingStatus._Text.Text as BookingStatusText : localized,
      LastChangedAt,
      /* Associations */
      _BookingSupplement : redirected to composition child ZC_LC_BOOKSUPPL_M,
      _BookingStatus,
      _Carrier,
      _Connection,
      _Customer,
      _Travel            : redirected to parent ZC_LC_TRAVEL_M
}
