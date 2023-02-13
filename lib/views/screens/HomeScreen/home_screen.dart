import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';
import 'package:provider/provider.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/category_controller.dart';
import 'package:store/controller/product_controller.dart';
import 'package:store/controller/user_controller.dart';
import 'package:store/enums/enums.dart';
import 'package:store/views/screens/CartScreen/cart_screen.dart';

import 'package:store/views/screens/MyOrderScreen/myorder_screen.dart';
import 'package:store/views/screens/ProductScreen/list_of_product_screen.dart';
import 'package:store/views/screens/ProductScreen/product_screen.dart';
import 'package:store/views/screens/ProfileScreen/profile_screen.dart';
import 'package:store/views/screens/SearchScreen/search_screen.dart';
import 'package:store/views/screens/TrendingScreen/trending_screen.dart';

class HomeScreen extends StatelessWidget {
  List<Color> color = [
    Color.fromARGB(255, 231, 93, 93),
    Colors.redAccent,
    Colors.blue,
    Colors.cyanAccent
  ];
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Grocy",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
              // Provider.of<UserController>(context, listen: false).setuser();
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: displayHeight(context) * 0.2,
                width: displayWidth(context) * 0.95,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 90, 237, 164),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/images/groceries-offers.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                child: Row(
                  children: [
                    Text(
                      "Categories",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Consumer<CategoryController>(
              builder: (context, categorycontroller, child) {
                if (categorycontroller.categorystatus == CategoryStatus.NIL) {
                  categorycontroller.setcategory();
                }
                switch (categorycontroller.categorystatus) {
                  case CategoryStatus.DONE:
                    return SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categorycontroller.categorylist.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListOfProduct(
                                        catId: categorycontroller
                                            .categorylist[index].categoryid!),
                                  ));
                            }),
                            child: Container(
                              width: 130,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      categorycontroller
                                          .categorylist[index].image,
                                      height: 130,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(categorycontroller
                                      .categorylist[index].categoryname)
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  case CategoryStatus.LOADING:
                    return SizedBox();
                  case CategoryStatus.NIL:
                    return SizedBox();
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                child: Row(
                  children: [
                    Text(
                      "Frequent Buy",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Consumer<ProductController>(
              builder: (context, productcontroller, child) {
                if (productcontroller.productfetchstatus ==
                    ProductFetchStatus.NIL) {
                  productcontroller.fetchproduct();
                  return CircularProgressIndicator();
                } else {
                  switch (productcontroller.productfetchstatus) {
                    case ProductFetchStatus.DONE:
                      // print("reached here");
                      if (productcontroller.frequentproduct.isEmpty) {
                        productcontroller.frequentprod();
                        return CircularProgressIndicator(
                          color: Colors.orange,
                        );
                      } else {
                        return SizedBox(
                          height: 170,
                          child: ListView.builder(
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: productcontroller.frequentproduct.length,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                            product: productcontroller
                                                .frequentproduct[index]),
                                      ));
                                },
                                child: Container(
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 3),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          productcontroller
                                              .frequentproduct[index].image,
                                          height: 130,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(productcontroller
                                          .frequentproduct[index].productname),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      }

                    case ProductFetchStatus.LOADING:
                      return CircularProgressIndicator(
                        color: Colors.red,
                      );
                    case ProductFetchStatus.NIL:
                      return CircularProgressIndicator();
                  }
                }
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: PandaBar(
        fabColors: [Colors.red, Colors.blue, Colors.cyanAccent],
        fabIcon: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.green[50],
        buttonData: [
          PandaBarButtonData(icon: Icons.home, title: "Home", id: 0),
          PandaBarButtonData(
              icon: Icons.shopify_outlined, title: "Trending", id: 1),
          PandaBarButtonData(icon: Icons.wallet, title: "My order", id: 2),
          PandaBarButtonData(icon: Icons.person, title: "My Profile", id: 3),
        ],
        // buttonSelectedColor: null,
        onChange: (id) {
          if (id == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => TrendingScreen())));
          }
          if (id == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => MyOrderScreen())));
          }
          if (id == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => ProfileScreen())));
          }
        },
        onFabButtonPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ));
        },
      ),
    );
  }
}
