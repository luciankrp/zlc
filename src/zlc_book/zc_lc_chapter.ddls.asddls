@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Chapter Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_LC_CHAPTER
  as projection on ZR_CHAPTER
{
  key BookId,
  key ChapterId,
      Title,
      PageCount,
      ContentSummary,
      CreatedBy,
      CreatedAt,
      LocalChangedBy,
      LocalChangedAt,
      LastChangedAt,

      /* Associations */
      _Book : redirected to parent ZC_LC_BOOK
}
