import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/controller/order_controller.dart';
import 'package:store/controller/product_controller.dart';
import 'package:store/controller/wishlist_controller.dart';
import 'package:store/enums/enums.dart';
import 'package:store/models/product_model.dart';
import 'package:store/views/screens/OrderSummaryScreen/order_summary_Screen.dart';

import '../../../constants/heigth_width_constant.dart';
import '../../../controller/cart_controller.dart';

class ProductScreen extends StatelessWidget {
  // String catId;
  // int index;
  Product product;

  ProductScreen(
      {super.key,
      // required this.catId,
      // required this.index,
      required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Product Screen"),
        backgroundColor: Colors.amber[600],
        actions: [
          Consumer<ProductController>(
            builder: (context, productcontroller, child) {
              return Consumer<WishlistController>(
                builder: (context, wishlistcontroller, child) {
                  return IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      if (wishlistcontroller.wishlistproducts.isEmpty) {
                        print("wishlistupdate");
                        wishlistcontroller.createdbwishlist(
                            pid: product.productid);
                      } else {
                        print("wishlistupdate");
                        wishlistcontroller.updatewishlist(
                            pid: product.productid);
                      }
                      Fluttertoast.showToast(
                        msg: "Item added to your wishlist",
                        fontSize: 16,
                        gravity: ToastGravity.BOTTOM,
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        decoration: BoxDecoration(color: Colors.amber[600]),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: Card(
              margin: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              elevation: 10,
              child: Container(
                  // white container

                  height: 900,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(15),
                    //   topRight: Radius.circular(15),
                    //   bottomLeft: Radius.circular(15),
                    //   bottomRight: Radius.circular(15),
                    // ),
                  ),
                  margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: Consumer<ProductController>(
                    builder: (context, productcontroller, child) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                product.image,
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 20, left: 20, bottom: 10),
                              child: Text(
                                "Product Details",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 19, vertical: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    "Brand   ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 130,
                                  ),
                                  Text(
                                    product.productname,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    // maxLines: 1,
                                    //overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    "Price    ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 132,
                                  ),
                                  Text(
                                    "₹ ${product.prize.toString()}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    "Weight  ",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 128,
                                  ),
                                  Text(
                                    "${product.weigth.toString()} gm",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    "Quantity avl",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 97,
                                  ),
                                  Text(
                                    "${product.qty.toString()} pieces",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            ),
          ),
          Row(
            children: [
              Consumer<OrderController>(
                builder: (context, ordercontroller, child) {
                  return Consumer<ProductController>(
                    builder: (context, productcontroller, child) {
                      return Consumer<CartController>(
                        builder: (context, cartcontroller, child) {
                          if (cartcontroller.cartstatus == CartStatus.NIL) {
                            cartcontroller.setcart();
                            return const CircularProgressIndicator();
                          } else {
                            return Container(
                              height: 55,
                              width: displayWidth(context) * 0.5,
                              color: Colors.white,
                              child: InkWell(
                                onTap: () async {
                                  ordercontroller.addproducttocartlist(
                                      productid: product.productid);
                                  if (cartcontroller.productlist.isEmpty) {
                                    await cartcontroller.createcartdb(
                                        productname: product.productname,
                                        categoryid: product.categoryid,
                                        productid: product.productid,
                                        prize: product.prize,
                                        qty: product.qty,
                                        weight: product.weigth!,
                                        image: product.image);
                                  } else {
                                    print("no empty");
                                    await cartcontroller.addproduct(
                                        productname: product.productname,
                                        categoryid: product.categoryid,
                                        productid: product.productid,
                                        prize: product.prize,
                                        qty: product.qty,
                                        weight: product.weigth!,
                                        image: product.image);
                                  }

                                  Fluttertoast.showToast(
                                    msg: "Item added to your cart",
                                    fontSize: 16,
                                    gravity: ToastGravity.SNACKBAR,
                                  );
                                },
                                child: const Center(
                                    child: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
              Consumer<ProductController>(
                builder: (context, productcontroller, child) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderSummaryScreen(product: product),
                          ));
                    },
                    child: Container(
                      height: 55,
                      width: displayWidth(context) * 0.5,
                      color: Colors.orange,
                      child: const Center(
                          child: Text(
                        "Buy now",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                    ),
                  );
                },
              )
            ],
          )
        ]),
      ),
    );
  }
}
