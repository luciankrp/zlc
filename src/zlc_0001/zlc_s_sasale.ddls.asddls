define abstract entity ZLC_S_SASale
{
  PartnerNumber      : zlc_demo_sa_partner;
  SalesDate          : zlc_demo_sa_date;
  @Semantics.amount.currencyCode: 'SalesCurrency'
  SalesVolume        : zlc_demo_sa_amount;
  SalesCurrency      : zlc_demo_sa_currency;
  @Semantics.amount.currencyCode: 'DifferenceCurrency'
  DifferenceAmount   : zlc_demo_sa_amount;
  DifferenceCurrency : zlc_demo_sa_currency;
  @Semantics.quantity.unitOfMeasure: 'DifferenceUnit'
  DifferenceQuantity : zlc_demo_sa_quantity;
  DifferenceUnit     : zlc_demo_sa_unit;
  SaleComment        : zlc_demo_sa_comment;
}
