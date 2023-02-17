import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/cart_controller.dart';
import 'package:store/controller/order_controller.dart';
import 'package:store/enums/enums.dart';
import 'package:store/models/product_model.dart';
import 'package:store/views/screens/PaymentScreen/cart_payment_screen.dart';
import 'package:store/views/screens/ProductScreen/product_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your cart"),
          backgroundColor: Colors.amber[600],
        ),
        body: Consumer<CartController>(
          builder: (context, cartcontroller, child) {
            //  var p = cartcontroller.productlist.isNotEmpty;
            if (cartcontroller.cartstatus == CartStatus.NIL) {
              cartcontroller.setcart();

              return const CircularProgressIndicator();
            } else {
              switch (cartcontroller.cartstatus) {
                case CartStatus.DONE:
                  Future.delayed(const Duration(microseconds: 1));
                  return (cartcontroller.productlist.isEmpty)
                      ? const Center(child: Text("no item in cart"))
                      : ListView.builder(
                          itemCount: cartcontroller.productlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductScreen(
                                          product: cartcontroller
                                              .productlist[index]),
                                    ));
                              },
                              child: Container(
                                height: 110,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    borderRadius: BorderRadius.circular(10)),
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15, bottom: 0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(cartcontroller
                                            .productlist[index].image),
                                      ),
                                    ),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 173,
                                          child: Text(
                                            "Brand:   ${cartcontroller.productlist[index].productname}",
                                            style: TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Price:   ₹ ${cartcontroller.productlist[index].prize.toString()}"),
                                        Row(
                                          children: [
                                            const Text("Quantity"),
                                            IconButton(
                                                onPressed: () {
                                                  cartcontroller
                                                      .cartquantityupdate(
                                                          index: index);
                                                  cartcontroller.billupdate(
                                                      index: index);
                                                },
                                                icon: const Icon(Icons.add)),
                                            Text(cartcontroller.quantity[index]
                                                .toString()),
                                            IconButton(
                                                onPressed: () {
                                                  cartcontroller
                                                      .cartquantitydecrease(
                                                          index: index);
                                                  cartcontroller.billdecreses(
                                                      index: index);
                                                },
                                                icon: const Icon(Icons.remove)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Consumer<OrderController>(
                                      builder:
                                          (context, ordercontroller, child) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: IconButton(
                                              onPressed: () async {
                                                Product cp = cartcontroller
                                                    .productlist[index];
                                                ordercontroller
                                                    .deleteproductfromcartlist(
                                                        productid:
                                                            cartcontroller
                                                                .productlist[
                                                                    index]
                                                                .productid);
                                                await cartcontroller
                                                    .deleteproduct(product: cp);
                                                cartcontroller.setquantity();

                                                cartcontroller.setquantity();
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Item removed from your cart",
                                                  fontSize: 16,
                                                  gravity: ToastGravity.CENTER,
                                                );
                                              },
                                              icon: const Icon(Icons.delete)),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                case CartStatus.LOADING:
                  return const CircularProgressIndicator();
                case CartStatus.NIL:
                  return const CircularProgressIndicator();
              }
            }
          },
        ),
        bottomNavigationBar: Consumer<CartController>(
          builder: (context, cartcontroller, child) {
            return Card(
              elevation: 20,
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(179, 247, 238, 238)),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Your total bill :   ₹ ",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                    (cartcontroller.cartstatus == CartStatus.DONE)
                        ? Text(
                            cartcontroller.bill.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: SizedBox(
                        width: displayWidth(context) * 0.4,
                        child: MaterialButton(
                          onPressed: () {
                            if (cartcontroller.productlist.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CartPaymentScreen(),
                                  ));
                            } else {
                              Fluttertoast.showToast(
                                msg: "Your cart is empty ",
                                fontSize: 16,
                                gravity: ToastGravity.BOTTOM,
                              );
                            }
                          },
                          color: Colors.orange,
                          child: const Text(
                            "Continue",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
