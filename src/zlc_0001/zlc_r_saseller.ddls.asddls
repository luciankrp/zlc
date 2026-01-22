@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define view entity ZLC_R_SASELLER
  as select from ZLC_SASELLER as SASELLER
  association to parent ZLC_R_SASALE as _SASALE on $projection.ParentUuid = _SASALE.Uuid
{
  key uuid as UUID,
  parent_uuid as ParentUUID,
  sellerid as Sellerid,
  quota as Quota,
  confirmed as Confirmed,
  _SASALE
}
