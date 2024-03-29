import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/controller/address_controller.dart';
import 'package:store/controller/auth_screen_controller.dart';
import 'package:store/controller/cart_controller.dart';
import 'package:store/controller/category_controller.dart';
import 'package:store/controller/order_controller.dart';
import 'package:store/controller/product_controller.dart';
import 'package:store/controller/search_controller.dart';
import 'package:store/controller/user_controller.dart';
import 'package:store/controller/wishlist_controller.dart';
import 'package:store/services/firebase/auth_service.dart';
import 'package:store/views/screens/AuthScreen/auth_screen.dart';
import 'package:store/views/screens/HomeScreen/home_screen.dart';
import 'package:store/views/screens/TrendingScreen/trending_screen.dart';

import 'views/screens/AddressScreen/address_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Store());
}

class Store extends StatelessWidget {
  const Store({super.key});

  Future<bool> getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool data = false;

    if (prefs.containsKey("login")) {
      //  print("preference found and its value is ${value.getBool("login")}");
      data = prefs.getBool("login")!;
    } else {
      print("no preference found");
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //AuthController
        ChangeNotifierProvider(create: ((context) => AuthScreenController())),
        //user controller
        ChangeNotifierProvider(
          create: ((context) => UserController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => CategoryController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => ProductController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => OrderController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => CartController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => SearchController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => WishlistController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => AddressController()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: getPref(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return HomeScreen();
                  // return TrendingScreen();
                }
                return AuthScreen();
              }
            }
            return AuthScreen();
          },
        ),
      ),
    );
  }
}
