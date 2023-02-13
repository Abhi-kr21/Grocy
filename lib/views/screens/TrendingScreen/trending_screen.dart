import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store/controller/product_controller.dart';
import 'package:store/views/screens/ProductScreen/product_screen.dart';

class TrendingScreen extends StatelessWidget {
  TrendingScreen({super.key});
  final Space = const SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              )),
          elevation: 0,
          backgroundColor: Colors.amber[600],
          title: Text(
            "Trending screen",
            style: TextStyle(color: Colors.black87),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // amber accent container
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber[600],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              ),
              child: Column(
                children: [
                  Space,
                  Space,
                  const Padding(
                    padding: const EdgeInsets.only(right: 140),
                    child: Text(
                      "Best Selling items",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: SizedBox(
                        height: 130,
                        child: Consumer<ProductController>(
                          builder: (context, productcontroller, child) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  productcontroller.bestSellingproduct.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  // best selling items container
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: EdgeInsets.all(9),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 9),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                product: productcontroller
                                                    .bestSellingproduct[index]),
                                          ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(16),
                                      ),
                                      child: Image.network(
                                        productcontroller
                                            .bestSellingproduct[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
            Space,
            const Padding(
              padding: EdgeInsets.only(right: 110),
              child: Text(
                "Most trending items ",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Space,
            Consumer<ProductController>(
              builder: (context, productcontroller, child) {
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 250,
                      // childAspectRatio: 1.2,
                      crossAxisCount: 2,
                      mainAxisSpacing: 18),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                                product:
                                    productcontroller.trendingproduct[index]),
                          )),
                      child: Card(
                        elevation: 10,
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 9, vertical: 9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.amberAccent.shade100,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                  child: Image.network(
                                    productcontroller
                                        .trendingproduct[index].image,
                                    height: 170,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    " Name : " +
                                        productcontroller
                                            .trendingproduct[index].productname,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .merge(TextStyle(
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                      " Price : ₹ ${productcontroller.trendingproduct[index].prize}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .merge(TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade500))),
                                ),
                                // Row(
                                //   children: [
                                //     IconButton(
                                //         onPressed: () {},
                                //         icon: Icon(Icons.favorite_border)),
                                //     IconButton(
                                //         onPressed: () {},
                                //         icon: Icon(Icons.shopping_cart_outlined))
                                //   ],
                                // )
                              ],
                            )),
                      ),
                    );
                  },
                  itemCount: productcontroller.trendingproduct.length,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
