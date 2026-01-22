@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement View'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_LC_BOOKSUPPL_M
  as select from zlc_booksuppl_m as BookingSupplement

  association        to parent ZR_LC_BOOKING_M as _Booking     on  $projection.TravelId  = _Booking.TravelId
                                                               and $projection.BookingId = _Booking.BookingId
  association [1..1] to ZR_LC_TRAVEL_M         as _Travel      on  $projection.TravelId = _Travel.TravelId

  association [1..1] to /DMO/I_Supplement      as _Product     on  $projection.SupplementId = _Product.SupplementID
  association [1..*] to /DMO/I_SupplementText  as _ProductText on  $projection.SupplementId = _ProductText.SupplementID
{
  key BookingSupplement.travel_id             as TravelId,
  key BookingSupplement.booking_id            as BookingId,
  key BookingSupplement.booking_supplement_id as BookingSupplementId,
      BookingSupplement.supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingSupplement.price                 as Price,
      BookingSupplement.currency_code         as CurrencyCode,
      // local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      BookingSupplement.last_changed_at       as LastChangedAt,

      /* Associations */
      _Booking,
      _Travel,
      _Product,
      _ProductText
}
