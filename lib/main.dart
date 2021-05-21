import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basics/database_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  late AuthResult authResult;
  void signUp(String email, String password) async {
    try {
      authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("User created:" + authResult.user.email);
    } catch (e) {
      print(e);
    }
  }

  void logIn(String email, String password) async {
    try {
      authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user.uid != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DatabasePage()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firbase Auth"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailText,
              decoration: InputDecoration(
                  hintText: "Enter email",
                  hintStyle: TextStyle(fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: passText,
              decoration: InputDecoration(
                  hintText: "Enter password",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () =>
                  signUp(emailText.text.toString(), passText.text.toString()),
              child: Text("Sign up"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  logIn(emailText.text.toString(), passText.text.toString());
                },
                child: Text("Log in")),
          ],
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in successfull"),
      ),
    );
  }
}
