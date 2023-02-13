import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controller/product_controller.dart';
import 'package:store/controller/search_controller.dart';
import 'package:store/views/screens/ProductScreen/product_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for product"),
        backgroundColor: Colors.amber[600],
      ),
      body: Column(
        children: [
          Consumer<SearchController>(
            builder: (context, searchController, child) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: TextFormField(
                  onChanged: (value) {
                    print(value);
                    searchController.fetchproducts(searchproduct: value);
                    // print("hii");
                  },
                  controller: searchcontroller,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(136, 238, 235, 235),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search here..",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
              );
            },
          ),
          Consumer<ProductController>(
            builder: (context, productcontroller, child) {
              return Expanded(child: Consumer<SearchController>(
                builder: (context, searchcontroller, child) {
                  return ListView.builder(
                    itemCount: searchcontroller.searchlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          // print(index);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                  // catId: searchcontroller
                                  //     .searchlist[index].categoryid,
                                  // index: productcontroller.searchindex(
                                  //   product:
                                  //       searchcontroller.searchlist[index],

                                  // )
                                  product: searchcontroller.searchlist[index],
                                ),
                              ));
                        },
                        // tileColor: Colors.white10,
                        contentPadding:
                            EdgeInsets.only(top: 10, left: 16, right: 16),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                searchcontroller.searchlist[index].image)),
                        title: Text(
                            searchcontroller.searchlist[index].productname),
                        trailing: Icon(Icons.arrow_forward_ios),
                      );
                    },
                  );
                },
              ));
            },
          )
        ],
      ),
    );
  }
}
