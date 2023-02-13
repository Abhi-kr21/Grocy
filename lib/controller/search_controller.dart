import 'package:flutter/cupertino.dart';
import 'package:store/constants/database.dart';
import 'package:store/models/product_model.dart';

class SearchController extends ChangeNotifier {
  List<Product> searchlist = [];
  List<Product> allProducts = [];
  List<List<Product>> data = [];
  fetchproducts({required String searchproduct}) async {
    List<Product> allProducts = [];
    if (allProducts.isEmpty) {
      var res = await productDb.get();
      for (var data in res.docs) {
        allProducts.add(Product.fromJson(data.data()));
      }
    }
    searchlist = allProducts
        .where((element) => element.productname
            .toLowerCase()
            .startsWith(searchproduct.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
