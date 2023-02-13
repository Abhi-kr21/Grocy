class Product {
  String productname;
  String productid;
  String categoryid;
  int prize;
  int qty;
  double? weigth;
  String image;
  bool? frequent;
  bool? istrending;
  bool? bestselling;
  Product(
      {required this.productname,
      required this.productid,
      required this.categoryid,
      required this.prize,
      required this.qty,
      required this.weigth,
      required this.image,
      this.bestselling,
      this.frequent,
      this.istrending});
  Map<String, dynamic> tojson() {
    return {
      "productname": productname,
      "productid": productid,
      "categoryid": categoryid,
      "prize": prize,
      "quantity": qty,
      "weight": weigth,
      "image": image
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productid: json['productid'],
        productname: json['productname'],
        categoryid: json['categoryid'],
        prize: json['prize'],
        weigth: json['weight'],
        qty: json['quantity'],
        image: json['image'],
        bestselling: json['bestselling'],
        frequent: json['frequentbuy'],
        istrending: json['trending']);
  }
}
