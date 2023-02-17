import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controller/order_controller.dart';
import 'package:store/controller/product_controller.dart';
import 'package:store/controller/search_controller.dart';
import 'package:store/enums/enums.dart';
import 'package:store/views/screens/OrderedProductScreen/ordered_product_screen.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text("Myorder"), backgroundColor: Colors.amber[600]),
        body: Consumer<OrderController>(
          builder: (context, ordercontroller, child) {
            if (ordercontroller.orderstatus == OrderStatus.NIL) {
              ordercontroller.fetchorder();
              return Center(child: CircularProgressIndicator());
            } else {
              switch (ordercontroller.orderstatus) {
                case OrderStatus.DONE:
                  return (ordercontroller.orders.isEmpty)
                      ? const Center(child: Text("No order made yet"))
                      : ListView.builder(
                          itemCount: ordercontroller.orders.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(ordercontroller.orders);
                            return Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(10),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Text(
                                          "order id : ${ordercontroller.orders[index].orderid}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Text(
                                          "Date&Time : ${ordercontroller.orders[index].madeorderon.toDate().toString()}"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderedProductScreen(
                                                index: index,
                                              ),
                                            ));
                                      },
                                      child: Text("view product"),
                                      color: Colors.orangeAccent,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                case OrderStatus.LOADING:
                  return Center(child: CircularProgressIndicator());
                case OrderStatus.NIL:
                  return CircularProgressIndicator();
              }
            }
          },
        ));
  }
}
