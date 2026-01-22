@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZLC_C_SASOLD
  as projection on ZLC_R_SASOLD
  association [1..1] to ZLC_R_SASOLD as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  ParentUUID,
  Materialid,
  _SASALE : redirected to parent ZLC_C_SASALE,
  _BaseEntity
}
