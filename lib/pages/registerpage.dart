import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/buttons.dart';
import '../widgets/mytextfield.dart';

class RegisterPage extends StatelessWidget {
  // text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _ConfirmpwController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //register method
  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();

    // passwords match -> create user
    if (_pwController.text == _ConfirmpwController.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _pwController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
      }
    }

    // passwords dont match
    else{
      showDialog(
          context: context,
          builder: (context) =>const  AlertDialog(
                title: Text("Passwords don't match !"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            // text
            Text(
              "Let's Create an Account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),

            // email textfield
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),

            // pw field
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),

            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _ConfirmpwController,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),

            // login button
            MyButton(
              text: "Register",
              onTap: () => register(context) ,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?  ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
