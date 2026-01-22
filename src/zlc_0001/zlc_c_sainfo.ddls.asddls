@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZLC_C_SAINFO
  as projection on ZLC_R_SAINFO
  association [1..1] to ZLC_R_SAINFO as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  ParentUUID,
  Text000,
  _SASALE : redirected to parent ZLC_C_SASALE,
  _BaseEntity
}
