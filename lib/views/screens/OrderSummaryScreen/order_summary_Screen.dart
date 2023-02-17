import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/product_controller.dart';
import 'package:store/models/product_model.dart';
import 'package:store/views/screens/PaymentScreen/payment_screen.dart';

class OrderSummaryScreen extends StatefulWidget {
  // String catid;
  // String pid;
  // int pindex;
  Product product;
  OrderSummaryScreen(
      {super.key,
      // required this.pid,
      // required this.catid,
      // required this.pindex,
      required this.product});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  int quantity = 1;

  int bill = 0;

  int increasequantity() {
    if (quantity < 10) {
      quantity += 1;
    }

    return quantity;
  }

  decreasequantity() {
    if (quantity > 1) {
      quantity -= 1;
      return quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(pindex.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Summary"),
          backgroundColor: Colors.amber[600],
        ),
        body: Consumer<ProductController>(
          builder: (context, productcontroller, child) {
            // bill = productcontroller.productList[catid]![pindex].prize;
            //  print(bill.toString());
            return ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: 4, right: 4, top: 5, bottom: 0),
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.amberAccent),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            widget.product.image,
                            height: 200,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Name : ${widget.product.productname}"),
                          SizedBox(
                            height: 15,
                          ),
                          Text(" price : ₹ ${widget.product.prize.toString()}"),
                          Row(
                            children: [
                              Text("Quantity"),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      increasequantity();
                                    });
                                  },
                                  icon: Icon(Icons.add)),
                              Text(quantity.toString()),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      decreasequantity();
                                    });
                                  },
                                  icon: Icon(Icons.remove)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: Consumer<ProductController>(
          builder: (context, productcontroller, child) {
            bill = quantity * (widget.product.prize);
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
                      "Your total bill :   ₹ ",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    Text(bill.toString()),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: SizedBox(
                        width: displayWidth(context) * 0.4,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentScreen(
                                      price: widget.product.prize,
                                      pid: widget.product.productid),
                                ));
                          },
                          color: Colors.orange,
                          child: Text(
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
