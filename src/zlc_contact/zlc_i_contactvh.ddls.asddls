@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Contact'
define view entity ZLC_I_CONTACTVH
  as select from ZLC_1_CONTACT
{
  key ContactId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZLC_I_ContactTypeVH', element: 'ContactTypeInt' } }]
      ContactTypeInt,
      concat_with_space(FirstName, LastName, 1) as FullName,
      Town,
      Country
}
