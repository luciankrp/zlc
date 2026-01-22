@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define view entity ZLC_R_SASOLD
  as select from ZLC_SASOLD as SASOLD
  association to parent ZLC_R_SASALE as _SASALE on $projection.ParentUuid = _SASALE.Uuid
{
  key uuid as UUID,
  parent_uuid as ParentUUID,
  materialid as Materialid,
  _SASALE
}
