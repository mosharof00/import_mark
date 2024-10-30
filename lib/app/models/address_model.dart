class Address {
  String id;
  String addressTitle;
  String name;
  String phone;
  String email;
  String city;
  String district;
  String area;
  String address;

  Address({
    required this.id,
    required this.addressTitle,
    required this.name,
    required this.phone,
    required this.email,
    required this.city,
    required this.district,
    required this.area,
    required this.address,
  });

  // Convert Address object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addressTitle': addressTitle,
      'name': name,
      'phone': phone,
      'email': email,
      'city': city,
      'district': district,
      'area': area,
      'address': address,
    };
  }

  // Create Address object from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      addressTitle: json['addressTitle'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      city: json['city'],
      district: json['district'],
      area: json['area'],
      address: json['address'],
    );
  }
}
