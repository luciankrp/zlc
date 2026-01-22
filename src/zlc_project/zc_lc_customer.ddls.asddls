@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Projection View'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_LC_CUSTOMER
  provider contract transactional_query
  as projection on ZR_LC_CUSTOMER
{
  key CustomerId,
      Name,
      City,
      Country,
      Createdby,
      Createdat,
      Localchangedby,
      Localchangedat,
      Lastchangedat,

      /* Associations */
      _Project   : redirected to composition child ZC_LC_PROJECT
}
