import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('images/logo.png'),
                height: 200,
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: kLoginInputDecoration.copyWith(
                    hintText: 'Enter your Email')),
            const SizedBox(
              height: 8,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration:
                    kLoginInputDecoration.copyWith(hintText: 'Enter Password')),
            const SizedBox(
              height: 24,
            ),
            RoundedButton(
              colour: Colors.lightBlueAccent,
              onPress: () {
                Navigator.pushNamed(context, ChatScreen.id);
              },
              title: 'Log In',
            )
          ],
        ),
      ),
    );
  }
}
