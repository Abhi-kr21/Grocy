import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/views/screens/CartScreen/cart_scren.dart';
import 'package:store/views/screens/MyOrderScreen/myorder_screen.dart';
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
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: displayHeight(context) * 0.15,
              width: displayWidth(context) * 0.95,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 90, 237, 164),
                borderRadius: BorderRadius.circular(20),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: color.length,
              itemBuilder: ((context, index) {
                return Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: color[index],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 3),
                );
              }),
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
                    "Frequent Buy",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
          SizedBox(
            height: 110,
            child: ListView.builder(
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: ((context, index) {
                return Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 193, 197, 198),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 3),
                );
              }),
            ),
          ),
        ],
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
