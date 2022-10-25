@AbapCatalog.sqlViewName: 'ZV_BKNG_2860'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface - Booking'
define view ZI_BOOKING_2860
  as select from ztb_booking_2860 as Booking
  composition [0..*] of ZI_BOOKINGSUPPL_2860 as _Bookingsplmnt
  association        to parent ZI_TRAVEL_2860 as _Travel        on $projection.travel_id = _Travel.travel_id
  association [1..1] to /DMO/I_Customer       as _Customer      on $projection.customer_id = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier        as _Carrier       on $projection.carrier_id = _Carrier.AirlineID
  association [1..*] to /DMO/I_Connection     as _Connection    on $projection.connection_id = _Connection.ConnectionID
{
  key travel_id,
  key booking_id,
      booking_date,
      customer_id,
      carrier_id,
      connection_id,
      flight_date,
      flight_price,
      currency_code,
      booking_status,
      last_changed_at,
      _Travel,
      _Bookingsplmnt,
      _Customer,
      _Carrier,
      _Connection
}
