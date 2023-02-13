import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/category_controller.dart';
import 'package:store/controller/order_controller.dart';

class PaymentScreen extends StatelessWidget {
  String pid;
  PaymentScreen({super.key, required this.pid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payments")),
      body: Column(),
      bottomNavigationBar: Card(
        elevation: 20,
        child: Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Text("your total bill"),
              Text("2555"),
              Padding(
                  padding: const EdgeInsets.only(left: 110),
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
                          },
                          color: Colors.orange,
                          child: Text(
                            "Continue",
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
