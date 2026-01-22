@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Book Projection View'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_LC_BOOK
  provider contract transactional_query
  as projection on ZR_BOOK
{
  key BookId,
      Title,
      Author,
      Genre,
      PublishYear,
      Logo,
      StatusIcon,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalChangedAt,
      LastChangedAt,

      /* Associations */
      _Chapter : redirected to composition child ZC_LC_CHAPTER
}
