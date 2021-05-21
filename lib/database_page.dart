import 'package:cloud_firestore/cloud_firestore.dart';
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
  void create(String name, int age) async {
    try {
      await firestore.collection("User").document("testUser").setData({
        'Username': name,
        'Age': age,
      });
    } catch (e) {}
  }

  void read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await firestore.collection("User").document("testUser").get();
      print(documentSnapshot.data);
    } catch (e) {}
  }

  void update() async {
    firestore.collection("User").document("testUser").updateData({
      'Username': 'Lucifer',
    });
  }

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
            ElevatedButton(onPressed: update, child: Text(" Update ")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}
