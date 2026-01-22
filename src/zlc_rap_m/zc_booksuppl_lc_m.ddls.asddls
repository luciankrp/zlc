@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Booking Supplements'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_booksuppl_lc_m
  as projection on ZI_booksuppl_lc_m
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      SupplementId,
      Price,
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _Booking : redirected to parent zc_booking_lc_m,
      _Supplement,
      _SupplementText,
      _Travel  : redirected to zc_travel_lc_m
}
