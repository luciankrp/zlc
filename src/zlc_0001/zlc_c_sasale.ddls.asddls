@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZLC_GLOBALSALE'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZLC_C_SASALE
  provider contract TRANSACTIONAL_QUERY
  as projection on ZLC_R_SASALE
  association [1..1] to ZLC_R_SASALE as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  Partnernumber,
  Salesdate,
  @Semantics: {
    Amount.Currencycode: 'Salescurrency'
  }
  Salesvolume,
  Salescurrency,
  @Semantics: {
    Amount.Currencycode: 'Differencecurrency'
  }
  Differenceamount,
  Differencecurrency,
  @Semantics: {
    Quantity.Unitofmeasure: 'Differenceunit'
  }
  Differencequantity,
  Differenceunit,
  Salecomment,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _SAINFO : redirected to composition child ZLC_C_SAINFO,
  _SASOLD : redirected to composition child ZLC_C_SASOLD,
  _SASELLER : redirected to composition child ZLC_C_SASELLER,
  _BaseEntity
}
