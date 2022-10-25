@EndUserText.label: 'Consumption - Travel'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_TRAVEL_2860
  provider contract transactional_query
  as projection on ZI_TRAVEL_2860
{
  key     travel_id          as TravelID,
          @ObjectModel.text.element: ['AgencyName']
          agency_id          as AgencyID,
          _Agency.Name       as AgencyName,
          @ObjectModel.text.element: ['CustomerName']
          customer_id        as CustomerID,
          _Customer.LastName as CustomerName,
          begin_date         as BeginDate,
          end_date           as EndDate,
          @Semantics.amount.currencyCode: 'CurrencyCode'
          booking_fee        as BookingFee,
          @Semantics.amount.currencyCode: 'CurrencyCode'
          total_price        as TotalPrice,
          @Semantics.currencyCode: true
          currency_code      as CurrencyCode,
          description        as Description,
          overall_status     as TravelStatus,
          last_changed_at    as LastChangedAt,
          @Semantics.amount.currencyCode: 'CurrencyCode'
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRT_ELMNT_2860'
  virtual DiscountPrice : /dmo/total_price,
          /* Associations */
          _Agency,
          _Booking : redirected to composition child ZC_BOOKING_2860,
          _Currency,
          _Customer
}
