import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../constants/database.dart';
import '../enums/enums.dart';
import '../models/product_model.dart';

class ProductController extends ChangeNotifier {
  ProductFetchStatus productfetchstatus = ProductFetchStatus.NIL;

  /// A map of string(category id) and list of product.
  Map<String, List<Product>> productList = {};

  /// A map of string(category id) and product status(enum).
  Map<String, ProductStatus> productStatusmap = {};

  List<Product> allproduct = [];
  List<Product> frequentproduct = [];
  List<Product> bestSellingproduct = [];
  List<Product> trendingproduct = [];

  setproducts({required String catId}) async {
    productStatusmap[catId] = ProductStatus.LOADING;
    await Future.delayed(Duration(microseconds: 1));
    notifyListeners();
    List<Product> tempList = [];
    try {
      var productSnapshot =
          await productDb.where("categoryid", isEqualTo: catId).get();

      for (var product in productSnapshot.docs) {
        Product p = Product.fromJson(product.data());
        tempList.add(p);
      }
    } catch (e) {
      print(e);
    }
    productList[catId] = tempList;
    productStatusmap[catId] = ProductStatus.DONE;
    notifyListeners();
  }

  // int searchindex({required Product product}) {
  //   print("object");
  //   return productList[product.categoryid]!
  //       .indexWhere((element) => element.productid == product.productid);

  //   // int index = -1;
  //   // productList[product.categoryid]!.forEach((element) {
  //   //   if (element.productid == product.productid) {
  //   //     index = productList[product.categoryid]!.indexOf(element);
  //   //   }
  //   // });
  //   // print(index);
  //   // return index;
  // }
  fetchproduct() async {
    productfetchstatus = ProductFetchStatus.LOADING;
    await Future.delayed(Duration(microseconds: 1));
    notifyListeners();
    var productSnapshots = await productDb.get();
    for (var product in productSnapshots.docs) {
      Product p = Product.fromJson(product.data());
      allproduct.add(p);
    }
    productfetchstatus = ProductFetchStatus.DONE;
    //frequentprod();
    trendingprod();
    bestsellingproduct();
    notifyListeners();
  }

  frequentprod() async {
    allproduct.forEach((element) {
      if (element.frequent!) {
        //  print("add");
        frequentproduct.add(element);
      }
    });
    // print(" hhhh:${frequentproduct}");
    await Future.delayed(Duration(microseconds: 1));
    notifyListeners();
  }

  bestsellingproduct() async {
    print("best selling items");
    allproduct.forEach((element) {
      if (element.bestselling!) {
        //  print("add");
        bestSellingproduct.add(element);
      }
    });
    // print(" hhhh:${frequentproduct}");
    // await Future.delayed(Duration(microseconds: 1));
    print(" length  ${bestSellingproduct.length}");
    bestSellingproduct.forEach(
      (element) => print(element.image),
    );
    print("endds");
    notifyListeners();
  }

  trendingprod() async {
    allproduct.forEach((element) {
      if (element.istrending!) {
        //  print("add");
        trendingproduct.add(element);
      }
    });
    // print(" hhhh:${frequentproduct}");
    // await Future.delayed(Duration(microseconds: 1));
    notifyListeners();
  }
}
