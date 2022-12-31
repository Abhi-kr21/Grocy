import 'package:flutter/material.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/views/screens/AuthScreen/login_screen.dart';
import 'package:store/views/screens/AuthScreen/sigup_screen.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final space = SizedBox(
    height: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Image.asset(
                "assets/images/auth.png",
                height: displayHeight(context) * 0.6,
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              "Hey! Welcome",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  letterSpacing: 1.2,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "A place for your grocery.",
              style: TextStyle(color: Colors.white),
            ),
            space,
            Center(
              child: SizedBox(
                width: displayWidth(context) * 0.83,
                child: MaterialButton(
                  height: displayHeight(context) * 0.055,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Login ",
                    style: TextStyle(fontSize: 15.5),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: displayWidth(context) * 0.83,
                child: MaterialButton(
                  height: displayHeight(context) * 0.055,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 15.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
