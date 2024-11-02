class ProductData {
  int? id;
  String? productName;
  String? slug;
  String? productSku;
  int? categoryId;
  int? subCategoryId;
  int? childCategoryId;
  int? brandId;
  String? productDescription;
  String? gander;
  dynamic youtubeEmbadecode;
  dynamic shippingType;
  dynamic shippigCost;
  dynamic shippingRtnPolicy;
  dynamic offerStart;
  dynamic offerEnd;
  int? discountPercent;
  dynamic multipleQty;
  dynamic metaName;
  dynamic metaTitle;
  dynamic metaImage;
  dynamic metaKeywords;
  dynamic metaDescription;
  int? totalStock;
  int? available;
  dynamic supplierId;
  int? sold;
  String? status;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? reviewsAvgRating;
  // List<ProductVariationData>? productvariations;
  // List<SizeData>? sizes;
  List<dynamic>? weights;

  ProductData({
    this.id,
    this.productName,
    this.slug,
    this.productSku,
    this.categoryId,
    this.subCategoryId,
    this.childCategoryId,
    this.brandId,
    this.productDescription,
    this.gander,
    this.youtubeEmbadecode,
    this.shippingType,
    this.shippigCost,
    this.shippingRtnPolicy,
    this.offerStart,
    this.offerEnd,
    this.discountPercent,
    this.multipleQty,
    this.metaName,
    this.metaTitle,
    this.metaImage,
    this.metaKeywords,
    this.metaDescription,
    this.totalStock,
    this.available,
    this.supplierId,
    this.sold,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.reviewsAvgRating,
    // this.productvariations,
    // this.sizes,
    this.weights,
  });}