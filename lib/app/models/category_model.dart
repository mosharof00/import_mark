class CategoryModel {
  int id;
  String image;
  String name;
  String description;

  CategoryModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
  });

  // Convert CategoryModel to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'description': description,
    };
  }

  // Convert Map to CategoryModel
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      description: map['description'],
    );
  }
}
