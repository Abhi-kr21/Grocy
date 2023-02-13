import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:store/constants/database.dart';
import 'package:store/enums/enums.dart';
import 'package:store/models/cart_model.dart';
import 'package:store/models/product_model.dart';

class CartController extends ChangeNotifier {
  CartStatus cartstatus = CartStatus.NIL;
  List<Product> productlist = [];
  List<int> quantity = [];
  int bill = 0;
  cartquantityupdate({required int index}) {
    if (quantity[index] > 0 && quantity[index] < 10) {
      ++quantity[index];
    }

    notifyListeners();
  }

  cartquantitydecrease({required int index}) {
    if (quantity[index] > 1) {
      --quantity[index];
    }

    notifyListeners();
  }

  setquantity() async {
    // Future.delayed(Duration(microseconds: 2));
    print("set");
    print(quantity.length);
    quantity = [];
    for (var i = 0; i < productlist.length; i++) {
      quantity.add(1);
    }
    print(productlist.length);
    print(quantity);
    int temp = 0;
    for (var i = 0; i < productlist.length; i++) {
      temp += (productlist[i].prize * quantity[i]);
    }
    bill = temp;
    await Future.delayed(Duration(microseconds: 1));
    notifyListeners();
  }

  billupdate({required int index}) {
    print("bill update");
    if (quantity[index] < 10) {
      bill = bill + productlist[index].prize;
    }

    notifyListeners();
  }

  billdecreses({required int index}) {
    print("bill decrese");
    if (quantity[index] > 1) {
      bill = bill - productlist[index].prize;
    }

    notifyListeners();
  }

  deleteproduct({required Product product}) async {
    //await cartdb.doc(uid).delete();

    // productlist.remove(product);
    int index = productlist
        .indexWhere((element) => element.productid == product.productid);
    if (index != -1) {
      productlist.removeAt(index);
      await cartdb.doc(uid).update(
          {'product': List<dynamic>.from(productlist.map((x) => x.tojson()))});
    }

    notifyListeners();
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;
  addproduct(
      {required String productname,
      required String categoryid,
      required String productid,
      required int prize,
      required int qty,
      required double weight,
      required String image}) async {
    try {
      bool productexist = false;
      Product product = Product(
          productname: productname,
          productid: productid,
          categoryid: categoryid,
          prize: prize,
          qty: qty,
          weigth: weight,
          image: image);
      //  int? index = productlist.indexWhere((element) => element.productid==productid);
      int? index;
      for (var i = 0; i < productlist.length; i++) {
        if (productid == productlist[i].productid) {
          index = i;
          productexist = true;
          break;
        }
      }
      if (productexist == false) {
        productlist.add(product);
        quantity.add(1);

        await cartdb.doc(uid).update({
          'product': List<dynamic>.from(productlist.map((x) => x.tojson()))
        });
      } else {
        cartquantityupdate(index: index!);
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  setcart() async {
    List<Product> temp = [];
    try {
      cartstatus = CartStatus.LOADING;
      await Future.delayed(Duration(microseconds: 1));
      notifyListeners();
      var cartSnapshots = await cartdb.doc(uid).get();
      Cart c = Cart.fromjson(cartSnapshots.data()!);
      temp = c.productlist;
    } catch (e) {
      print(e);
    }
    productlist = temp;
    // for (int i = 0; i < productlist.length; ++i) {
    //   quantity.add(1);
    // }
    cartstatus = CartStatus.DONE;
    setquantity();
    notifyListeners();
  }

  clearcart() async {
    try {
      await cartdb.doc(uid).delete();
      productlist.clear();
      bill = 0;
      quantity.clear();
      print("clearcart");
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  createcartdb(
      {required String productname,
      required String categoryid,
      required String productid,
      required int prize,
      required int qty,
      required double weight,
      required String image}) async {
    try {
      Product product = Product(
          productname: productname,
          productid: productid,
          categoryid: categoryid,
          prize: prize,
          qty: qty,
          weigth: weight,
          image: image);
      Cart cart = Cart(userid: uid, cartid: uid, productlist: [product]);
      var res = await cartdb.doc(uid).set(cart.tojson());
      productlist.add(product);
      quantity.add(1);
      setquantity();
      // res.update({'cartid': res.id});
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
