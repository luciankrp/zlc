@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Booking Supplements'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #M,
    dataClass: #TRANSACTIONAL
}
define view entity ZI_booksuppl_lc_m
  as select from zbooksuppl_lc_m
  association        to parent zi_booking_lc_m as _Booking        on  $projection.TravelId  = _Booking.TravelId
                                                                  and $projection.BookingId = _Booking.BookingId
  association [1]    to ZI_TRAVEL_LC_M         as _Travel         on  $projection.TravelId = _Travel.TravelId
  association [1]    to /DMO/I_Supplement      as _Supplement     on  $projection.SupplementId = _Supplement.SupplementID
  association [1..*] to /DMO/I_SupplementText  as _SupplementText on  $projection.SupplementId = _SupplementText.SupplementID
{
  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,

      _Booking,
      _Travel,
      _Supplement,
      _SupplementText
}
