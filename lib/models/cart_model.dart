// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:store/models/product_model.dart';

class Cart {
  String userid;
  String cartid;
  List<Product> productlist;
  Cart({
    required this.userid,
    required this.cartid,
    required this.productlist,
  });

  Map<String, dynamic> tojson() {
    return {
      "uid": userid,
      "cartid": cartid,
      "product": productlist == null
          ? []
          : List<dynamic>.from(productlist.map((x) => x.tojson())),
    };
  }

  factory Cart.fromjson(Map<String, dynamic> map) {
    return Cart(
      userid: map['uid'] as String,
      cartid: map['cartid'] as String,
      productlist: List<Product>.from(
        (map['product'] as List<dynamic>).map<Product>(
          (x) => Product.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
