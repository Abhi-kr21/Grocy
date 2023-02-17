import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/category_controller.dart';
import 'package:store/controller/order_controller.dart';
import 'package:store/views/screens/HomeScreen/home_screen.dart';

class PaymentScreen extends StatelessWidget {
  String pid;
  int price;
  PaymentScreen({super.key, required this.pid, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payments"),
        backgroundColor: Colors.amber[600],
      ),
      body: Column(),
      bottomNavigationBar: Card(
        elevation: 20,
        child: Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Text(
                "Your total bill :   ₹ " + price.toString(),
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Consumer<OrderController>(
                    builder: (context, ordercontroller, child) {
                      return SizedBox(
                        width: displayWidth(context) * 0.4,
                        child: MaterialButton(
                          onPressed: () async {
                            ordercontroller.addproducttolist(productid: pid);
                            await ordercontroller.makeorder(
                                //  productlists: ordercontroller.productlist,
                                madeorderon: Timestamp.now());
                            ordercontroller.emptyproductlist();
                            Fluttertoast.showToast(
                              msg: "Order Successfull",
                              fontSize: 16,
                              gravity: ToastGravity.BOTTOM,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                          },
                          color: Colors.orange,
                          child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
