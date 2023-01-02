class ProductModel {
  String id;
  String name;
  String prize;
  String brandname;
  int? rating;
  int? totalpurchases;
  ProductModel(
      {required this.id,
      required this.name,
      required this.prize,
      required this.brandname,
      required this.rating,
      required this.totalpurchases});

  ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['productid'],
        name: json['name'],
        prize: json['prize'],
        brandname: json['email'],
        rating: json['rating'],
        totalpurchases: json['totalpurchases']);
  }
}
