import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/order_controller.dart';

class OrderedProductScreen extends StatelessWidget {
  OrderedProductScreen({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Your ordered products"),
            backgroundColor: Colors.amber[600]),
        body: Consumer<OrderController>(
          builder: (context, ordercontroller, child) {
            return ListView.builder(
              itemCount: ordercontroller.data[index].length,
              itemBuilder: (BuildContext context, int pndex) {
                return Container(
                  height: 110,
                  width: displayWidth(context) * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(10)),
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                                ordercontroller.data[index][pndex].image)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("Product name : "),
                              Text(ordercontroller
                                  .data[index][pndex].productname)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("Price :  "),
                              Text(ordercontroller.data[index][pndex].prize
                                  .toString())
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("Weight : "),
                              Text(ordercontroller.data[index][pndex].weigth
                                  .toString())
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
