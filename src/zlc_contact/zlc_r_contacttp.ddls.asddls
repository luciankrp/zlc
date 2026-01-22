@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Contact'
define root view entity ZLC_R_ContactTP
  as select from ZLC_1_CONTACT
  association of one to one ZLC_I_ContactTypeVH as _ContactTypeInternal on $projection.ContactTypeInt = _ContactTypeInternal.ContactTypeInt
  association of one to one ZLC_I_CONTACTVH     as _ContactInfo         on $projection.ContactId = _ContactInfo.ContactId
  association of one to one I_CountryVH         as _Country             on $projection.Country = _Country.Country
{
  key ContactId,
      ContactTypeInt,
      FirstName,
      LastName,
      Birthday,
      Street,
      HouseNumber,
      Town,
      ZipCode,
      Country,
      Telephone,
      Email,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      //* Associations *//
      _ContactInfo,
      _ContactTypeInternal,
      _Country
}
