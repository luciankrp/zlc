@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Chapter View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_CHAPTER
  as select from zlc_chapter as Chapter

  association to parent ZR_BOOK as _Book on $projection.BookId = _Book.BookId
{
  key Chapter.book_id          as BookId,
  key Chapter.chapter_id       as ChapterId,
      Chapter.title            as Title,
      Chapter.page_count       as PageCount,
      Chapter.content_summary  as ContentSummary,
      @Semantics.user.createdBy: true
      Chapter.created_by       as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      Chapter.creted_at        as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      Chapter.local_changed_by as LocalChangedBy,
      // Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Chapter.local_changed_at as LocalChangedAt,
      // Total Etag
      @Semantics.systemDateTime.lastChangedAt: true
      Chapter.last_changed_at  as LastChangedAt,

      /* Associations */
      _Book
}
