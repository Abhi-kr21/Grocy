import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/cart_controller.dart';
import 'package:store/controller/order_controller.dart';

class CartPaymentScreen extends StatelessWidget {
  const CartPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Payment Screen"),
        backgroundColor: Colors.amber[600],
      ),
      bottomNavigationBar: Consumer<CartController>(
        builder: (context, cartcontroller, child) {
          return Consumer<OrderController>(
            builder: (context, ordercontroller, child) {
              return Card(
                elevation: 20,
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Color.fromARGB(179, 247, 238, 238)),
                  child: Row(
                    children: [
                      Text(
                        "   Your total bill :   ",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      Text(
                        " ₹ ${cartcontroller.bill.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: InkWell(
                          onTap: () async {},
                          child: SizedBox(
                            width: displayWidth(context) * 0.4,
                            child: MaterialButton(
                              onPressed: () async {
                                // print("hrl");
                                await ordercontroller.makeordercart();
                                await ordercontroller.emptycartlist();
                                cartcontroller.clearcart();
                              },
                              color: Colors.orange,
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
