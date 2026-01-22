@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Book View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZR_BOOK
  as select from zlc_book as Book

  composition [*] of ZR_CHAPTER as _Chapter
{
  key Book.book_id          as BookId,
      Book.title            as Title,
      Book.author           as Author,
      Book.genre            as Genre,
      Book.publish_year     as PublishYear,
      @Semantics.imageUrl: true
      Book.logo             as Logo,
      @Semantics.imageUrl: true
      Book.status_icon      as StatusIcon,
      @Semantics.user.createdBy: true
      Book.created_by       as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      Book.creted_at        as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      Book.local_changed_by as LocalChangedBy,
      // Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Book.local_changed_at as LocalChangedAt,
      // Total Etag
      @Semantics.systemDateTime.lastChangedAt: true
      Book.last_changed_at  as LastChangedAt,

      /* Associations */
      _Chapter
}
