import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/constants/database.dart';
import 'package:store/enums/enums.dart';
import 'package:store/models/order_model.dart';
import 'package:store/models/product_model.dart';

class OrderController extends ChangeNotifier {
  List<OrderModel> orders = [];
  List<String> productlist = [];
  List<String> cartlist = [];
  List<List<Product>> data = [];
  OrderStatus orderstatus = OrderStatus.NIL;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  makeorder(
      {
      //required List<String> productlists,
      required Timestamp madeorderon}) async {
    try {
      OrderModel order = OrderModel(
          orderid: "",
          userid: uid,
          productlist: productlist,
          madeorderon: madeorderon);

      var res = await orderdb
          .doc(uid)
          .collection("totals orders")
          .add(order.tojson());
      await orderdb.doc(uid).update({'uid': uid});
      await res.update({'orderid': res.id});
      print("order succesfull");
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  addproducttolist({required String productid}) {
    print("added producct");
    productlist.add(productid);
    notifyListeners();
  }

  emptyproductlist() {
    print("list clear");
    productlist.clear();
    notifyListeners();
  }

  makeordercart() async {
    try {
      print(" cart order succesfull");
      OrderModel order = OrderModel(
          orderid: "",
          userid: uid,
          productlist: cartlist,
          madeorderon: Timestamp.now());

      var res = await orderdb
          .doc(uid)
          .collection("totals orders")
          .add(order.tojson());
      await res.update({'orderid': res.id});
      // await res.update({'orderid': res.id});
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  deleteproductfromcartlist({required String productid}) {
    cartlist.remove(productid);
    notifyListeners();
  }

  addproducttocartlist({required String productid}) {
    // print("added producct to cart list");
    cartlist.add(productid);
    print(cartlist);
    notifyListeners();
  }

  emptycartlist() {
    print("cart list clear");
    cartlist.clear();
    notifyListeners();
  }

  fetchorder() async {
    orderstatus = OrderStatus.LOADING;
    await Future.delayed(Duration(microseconds: 1));
    notifyListeners();

    List<OrderModel> temp = [];
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final ordersnapshot =
        await orderdb.doc(uid).collection("totals orders").get();
    for (var data in ordersnapshot.docs) {
      OrderModel order = OrderModel.fromjson(data.data());
      temp.add(order);
    }
    orders = temp;
    List<Product> t = [];
    for (var od in orders) {
      for (var pid in od.productlist) {
        var pmsnap = await productDb.doc(pid).get();
        var c = Product.fromJson(pmsnap.data()!);
        t.add(c);
      }
      data.add(t);
      t = [];
    }
    orderstatus = OrderStatus.DONE;
    notifyListeners();
  }
}
