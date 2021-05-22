import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabasePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DatabasePageState();
  }
}

class DatabasePageState extends State<DatabasePage> {
  TextEditingController testName = TextEditingController();
  TextEditingController testAge = TextEditingController();
  Firestore firestore = Firestore.instance;
  //var firebaseUser = FirebaseAuth.instance.currentUser ;
  void create(String name, int age) async {
    try {
      await firestore.collection("User").document().setData({
        'Username': name,
        'Age': age,
      });
    } catch (e) {}
  }

  void read() async {
    QuerySnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore.collection("User").getDocuments();
      for (int i = 0; i < documentSnapshot.documents.length; i++) {
        var a = documentSnapshot.documents[i];
        print(a.data);
      }
    } catch (e) {}
  }

  /* void update() async {
    firestore.collection("User").document("testUser").updateData({
      'Username': 'Lucifer',
    });
  }*/

  void delete() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DataBasePage'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: testName,
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: testAge,
              decoration: InputDecoration(
                hintText: 'Age',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  create(testName.text.toString(),
                      int.parse(testAge.text.toString()));
                },
                child: Text("Add ")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: read, child: Text(" Read ")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: Text(" Update ")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}
