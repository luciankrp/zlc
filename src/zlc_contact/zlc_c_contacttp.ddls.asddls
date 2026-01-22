@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Contact (Consumption)'
@Metadata.allowExtensions: true
@Search.searchable: true
@UI.headerInfo.typeImageUrl: #(ContactTypeIcon)
@ObjectModel.semanticKey: [ 'ContactId' ]
define root view entity ZLC_C_CONTACTTP
  provider contract transactional_query
  as projection on ZLC_R_ContactTP
{
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZLC_I_CONTACTVH', element: 'ContactId' } }]
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 1.0
  key     ContactId,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZLC_I_ContactTypeVH', element: 'ContactTypeInt' } }]
          ContactTypeInt,
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          FirstName,
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          LastName,
          _ContactInfo.FullName,
          Birthday,
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          Street,
          HouseNumber,
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          Town,
          ZipCode,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CountryVH', element: 'Country' } }]
          @ObjectModel.text.element: [ 'CountryName' ]
          @UI.textArrangement: #TEXT_FIRST
          Country,
          _Country.Description as CountryName,
          Telephone,
          Email,
          LocalCreatedBy,
          LocalCreatedAt,
          LocalLastChangedBy,
          LocalLastChangedAt,
          LastChangedAt,

          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_LC_CONTACT_CALC'
  virtual ContactTypeIcon      : abap.string,

          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_LC_CONTACT_CALC'
  virtual isHiddenTelephone    : abap_boolean,

          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_LC_CONTACT_CALC'
  virtual isHiddenEmail        : abap_boolean,

          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_LC_CONTACT_CALC'
  virtual isHiddenBirthday     : abap_boolean,

          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_LC_CONTACT_CALC'
  virtual isHiddenContactFacet : abap_boolean,

          //* Associations *//
          _ContactInfo,
          _ContactTypeInternal,
          _Country
}
