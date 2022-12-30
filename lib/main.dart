import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/controller/auth_screen_controller.dart';
import 'package:store/services/firebase/auth_service.dart';
import 'package:store/views/authscreen/auth_screen.dart';
import 'package:store/views/authscreen/login_screen.dart';
import 'package:store/views/authscreen/sigup_screen.dart';
import 'package:store/views/homescreen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Store());
}

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  }

  Future<bool> getPref() async {
    bool data = false;

    await prefs.then(
      (value) {
        if (value.containsKey("login")) {
          //  print("preference found and its value is ${value.getBool("login")}");
          data = value.getBool("login")!;
        } else {
          print("no preference found");
        }
      },
    );

    return data;
  }

  @override
  Widget build(BuildContext context) {
    bool Isloggedin = false;
    return MultiProvider(
      providers: [
        //AuthController
        ChangeNotifierProvider(create: ((context) => AuthScreenController()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: getPref(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return HomeScreen();
                // return AuthScreen();
              }
              return AuthScreen();
            }
            return AuthScreen();
          },
        ),
      ),
    );
  }
}
