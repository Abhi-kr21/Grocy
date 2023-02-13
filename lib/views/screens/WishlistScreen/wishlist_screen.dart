import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/wishlist_controller.dart';
import 'package:store/enums/enums.dart';
import 'package:store/views/screens/ProductScreen/product_screen.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Wishlist"),
          backgroundColor: Colors.amber[600],
        ),
        body: Consumer<WishlistController>(
          builder: (context, wishlistcontroller, child) {
            print("wishlist");
            if (wishlistcontroller.wishliststatus == WishListStatus.NIL) {
              wishlistcontroller.fetchwishlist();
              return CircularProgressIndicator();
            } else {
              switch (wishlistcontroller.wishliststatus) {
                case WishListStatus.DONE:
                  print(wishlistcontroller.wishlistproducts);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: wishlistcontroller.wishlistproducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                  product: wishlistcontroller
                                      .wishlistproducts[index],
                                ),
                              ));
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 0),
                          child: Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(wishlistcontroller
                                          .wishlistproducts[index].image),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          " Name : ${wishlistcontroller.wishlistproducts[index].productname}"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          " Price :  ₹ ${wishlistcontroller.wishlistproducts[index].prize}"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          " Weight : ${wishlistcontroller.wishlistproducts[index].weigth}")
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                  top: displayHeight(context) * 0.025,
                                  left: 300,
                                  child: Consumer<WishlistController>(
                                    builder:
                                        (context, wishlistcontroller, child) {
                                      return IconButton(
                                          onPressed: () {
                                            wishlistcontroller.deletewishlist(
                                                product: wishlistcontroller
                                                    .wishlistproducts[index]);
                                            Fluttertoast.showToast(
                                                msg: "Item removed",
                                                fontSize: 16);
                                          },
                                          icon: Icon(Icons.delete));
                                    },
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                case WishListStatus.LOADING:
                  return CircularProgressIndicator();
                case WishListStatus.NIL:
                  return CircularProgressIndicator();
              }
            }
          },
        ));
  }
}
