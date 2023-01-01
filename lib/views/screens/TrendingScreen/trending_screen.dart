import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/single_child_widget.dart';

class TrendingScreen extends StatelessWidget {
  TrendingScreen({super.key});
  final Space = const SizedBox(
    height: 10,
  );
  List<Color> color = [
    Colors.lightGreen,
    Colors.redAccent,
    Colors.blue,
    Colors.cyanAccent,
    Colors.deepOrange,
    Colors.yellowAccent,
  ];

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
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: trendimages.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            width: 130,
                            decoration: BoxDecoration(
                              color: color[index],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              child: Image.asset(
                                trendimages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
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
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 290,
                  // childAspectRatio: 1.2,
                  crossAxisCount: 2,
                  mainAxisSpacing: 18),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.amberAccent.shade100,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            child: Image.asset(
                              trendimages[index],
                              height: 170,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              names[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(price[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .merge(TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade500))),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.shopping_cart_outlined))
                            ],
                          )
                        ],
                      )),
                );
              },
              itemCount: trendimages.length,
            ),
          ],
        ),
      ),
    );
  }
}

List<String> trendimages = [
  "assets/images/noodles.jpg",
  "assets/images/cookies.jpg",
  "assets/images/honey.jpg",
  "assets/images/yogurt.jpg",
  "assets/images/chocolate.jpg",
  "assets/images/oil.jpg"
];
List<String> names = [
  "Noodles",
  "Cookies",
  "Honey",
  "Yogurt",
  " Chocolate",
  "Olive oil"
];
List<String> price = [
  "Rupees 25",
  "Rupees 50",
  "Rupees 30",
  "Rupees 35",
  "Rupees 120",
  "Rupees 150"
];
