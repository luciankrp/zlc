@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Contact (Base)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZLC_1_CONTACT
  as select from zlc_contact
{
  key contact_id            as ContactId,
      contact_type          as ContactTypeInt,
      first_name            as FirstName,
      last_name             as LastName, 
      birthday              as Birthday,
      street                as Street,
      house_number          as HouseNumber,
      town                  as Town,
      zip_code              as ZipCode,
      country               as Country,
      telephone             as Telephone,
      email                 as Email,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt
}
