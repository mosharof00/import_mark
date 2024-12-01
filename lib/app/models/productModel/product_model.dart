class ProductModel {
  int id;
  String productName;
  String? productDescription;
  List<ProductColor> colorList;
  List<String> images;
  String? productSku;
  int categoryId;
  String? shippingType;
  int? shippingCost;
  int buyingPrice;
  int salePrice;
  int? discountPercent;
  int? totalStock;
  int? available;
  int? sold;
  bool isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.productName,
    this.productDescription,
    required this.colorList,
    required this.images,
    this.productSku,
    required this.categoryId,
    this.shippingType,
    this.shippingCost,
    required this.buyingPrice,
    required this.salePrice,
    this.discountPercent,
    this.totalStock,
    this.available,
    this.sold,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  // Convert ProductData to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'productDescription': productDescription,
      'colorList': colorList.map((color) => color.toMap()).toList(),
      'images': images,
      'productSku': productSku,
      'categoryId': categoryId,
      'shippingType': shippingType,
      'shippingCost': shippingCost,
      'buyingPrice': buyingPrice,
      'salePrice': salePrice,
      'discountPercent': discountPercent,
      'totalStock': totalStock,
      'available': available,
      'sold': sold,
      'isActive': isActive,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  // Convert Map to ProductData
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      productName: map['productName'],
      productDescription: map['productDescription'],
      colorList: (map['colorList'] as List)
          .map((color) => ProductColor.fromMap(color))
          .toList(),
      images: List<String>.from(map['images']),
      productSku: map['productSku'],
      categoryId: map['categoryId'],
      shippingType: map['shippingType'],
      shippingCost: map['shippingCost'],
      buyingPrice: map['buyingPrice'],
      salePrice: map['salePrice'],
      discountPercent: map['discountPercent'],
      totalStock: map['totalStock'],
      available: map['available'],
      sold: map['sold'],
      isActive: map['isActive'],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }
}

class ProductColor {
  int id;
  String colorCode;
  String name;

  ProductColor({
    required this.id,
    required this.colorCode,
    required this.name,
  });

  // Convert ProductColor to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'colorCode': colorCode,
      'name': name,
    };
  }

  // Convert Map to ProductColor
  factory ProductColor.fromMap(Map<String, dynamic> map) {
    return ProductColor(
      id: map['id'],
      colorCode: map['colorCode'],
      name: map['name'],
    );
  }
}
