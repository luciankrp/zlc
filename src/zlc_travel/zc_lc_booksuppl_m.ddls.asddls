@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Projection View'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_LC_BOOKSUPPL_M
  as projection on ZR_LC_BOOKSUPPL_M
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      @ObjectModel.text.element: [ 'SupplementDesc' ]
      SupplementId,
      _ProductText.Description as SupplementDesc : localized,
      Price,
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZC_LC_BOOKING_M,
      _Product,
      _ProductText,
      _Travel  : redirected to ZC_LC_TRAVEL_M
}
