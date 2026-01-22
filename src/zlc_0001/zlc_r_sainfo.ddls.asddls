@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define view entity ZLC_R_SAINFO
  as select from ZLC_SAINFO as SAINFO
  association to parent ZLC_R_SASALE as _SASALE on $projection.ParentUuid = _SASALE.Uuid
{
  key uuid as UUID,
  parent_uuid as ParentUUID,
  text000 as Text000,
  _SASALE
}
