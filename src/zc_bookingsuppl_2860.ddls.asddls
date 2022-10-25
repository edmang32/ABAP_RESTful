@EndUserText.label: 'Consumption - Booking Supplement'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_BOOKINGSUPPL_2860
  as projection on ZI_BOOKINGSUPPL_2860
{

  key travel_id                   as TravelID,
  key booking_id                  as BookingID,
  key booking_supplement_id       as BookingSupplementID,
      @ObjectModel.text.element: ['SupplementDescription']
      supplement_id               as SupplementID,
      _SupplementText.Description as SupplementDescription : localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                       as price,
      @Semantics.currencyCode: true
      currency_code               as CurrencyCode,
      last_changed_at             as LastChangedAt,
      /* Associations */
      _Travel  : redirected to ZC_TRAVEL_2860,
      _Booking : redirected to parent ZC_BOOKING_2860,
      _Product,
      _SupplementText
}
