import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/constants/database.dart';
import 'package:store/enums/enums.dart';
import 'package:store/models/product_model.dart';
import 'package:store/models/wishlist_model.dart';

class WishlistController extends ChangeNotifier {
  // List<String> productlist = [];
  List<Product> products = [];
  List<Product> wishlistproducts = [];
  WishListStatus wishliststatus = WishListStatus.NIL;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  setwishlist() {}
  createdbwishlist({required String pid}) async {
    WishList wishlist = WishList(productid: [pid]);
    await wishlistdb.doc(uid).set(wishlist.toMap());

    products.forEach((product) {
      if (pid == product.productid) {
        wishlistproducts.add(product);
      }
    });
    notifyListeners();
    // productlist.add(pid);
  }

  updatewishlist({required String pid}) async {
    var wishlistSnapshots = await wishlistdb.doc(uid).get();
    WishList wishlist = WishList.fromMap(wishlistSnapshots.data()!);
    var index =
        wishlistproducts.indexWhere((element) => element.productid == pid);
    if (index == -1) {
      wishlist.productid.add(pid);
      // List<String> product = wishlist.productid;
      await wishlistdb.doc(uid).update({'productid': wishlist.productid});
      var index1 = products.indexWhere((element) => element.productid == pid);
      wishlistproducts.add(products[index1]);
    }
    notifyListeners();
  }

  fetchwishlist() async {
    wishliststatus = WishListStatus.LOADING;
    await Future.delayed(Duration(microseconds: 1));
    notifyListeners();
    var wishlistSnapshot = await wishlistdb.doc(uid).get();
    if (wishlistSnapshot.data() != null) {
      WishList wishlist = WishList.fromMap(wishlistSnapshot.data()!);
      var productsnapshots = await productDb.get();

      for (var product in productsnapshots.docs) {
        Product p = Product.fromJson(product.data());
        products.add(p);
      }
      wishlist.productid.forEach((element) {
        products.forEach((product) {
          if (element == product.productid) {
            wishlistproducts.add(product);
          }
        });
      });
    }

    wishliststatus = WishListStatus.DONE;
    notifyListeners();
  }

  deletewishlist({required Product product}) async {
    var wishlistSnapshots = await wishlistdb.doc(uid).get();
    WishList wishlist = WishList.fromMap(wishlistSnapshots.data()!);
    wishlist.productid.remove(product.productid);
    await wishlistdb.doc(uid).update({'productid': wishlist.productid});
    wishlistproducts.remove(product);
    notifyListeners();
  }
}
