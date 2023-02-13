import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controller/product_controller.dart';
import 'package:store/views/screens/ProductScreen/product_screen.dart';

import '../../../enums/enums.dart';

class ListOfProduct extends StatelessWidget {
  String catId;
  ListOfProduct({super.key, required this.catId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of product"),
        backgroundColor: Colors.amber[600],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ProductController>(
              builder: (context, productcontroller, child) {
                if (!productcontroller.productStatusmap.containsKey(catId)) {
                  productcontroller.setproducts(catId: catId);
                  return Center(child: CircularProgressIndicator());
                } else {
                  switch (productcontroller.productStatusmap[catId]!) {
                    case ProductStatus.DONE:
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 195,
                                crossAxisCount: 2,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0),
                        itemCount: productcontroller.productList[catId]!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                      product: productcontroller
                                          .productList[catId]![index],
                                      // catId: catId,
                                      // index: index
                                    ),
                                  ));
                            },
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.amberAccent),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        productcontroller
                                            .productList[catId]![index].image,
                                        height: 139,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                      " Brand:  ${productcontroller.productList[catId]![index].productname}"),
                                  Text(
                                      " Price  : ₹ ${productcontroller.productList[catId]![index].prize.toString()}"),
                                  SizedBox(height: 4),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    case ProductStatus.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case ProductStatus.NIL:
                      return Center(child: CircularProgressIndicator());
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
